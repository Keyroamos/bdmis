import africastalking
from africastalking.Service import AfricasTalkingException
from django.conf import settings
import logging

logger = logging.getLogger(__name__)

def initialize_africastalking():
    """Initialize Africa's Talking with error handling"""
    try:
        username = settings.AFRICASTALKING_USERNAME
        api_key = settings.AFRICASTALKING_API_KEY
        
        # Log credentials (mask API key for security)
        masked_key = api_key[:10] + '...' + api_key[-10:] if len(api_key) > 20 else '***'
        logger.info(f"Initializing Africa's Talking with username: {username}, API key: {masked_key}")
        
        if not username or not api_key:
            error_msg = "Missing Africa's Talking credentials. Please check AFRICASTALKING_USERNAME and AFRICASTALKING_API_KEY in settings."
            logger.error(error_msg)
            return None, error_msg
        
        africastalking.initialize(username, api_key)
        sms_service = africastalking.SMS
        logger.info("Africa's Talking initialized successfully")
        return sms_service, None
    except Exception as e:
        error_msg = f"Failed to initialize Africa's Talking: {str(e)}"
        logger.error(error_msg)
        return None, error_msg

def send_bulk_sms(phone_numbers, message):
    """
    Send bulk SMS using Africa's Talking
    """
    try:
        # Initialize on each call to get fresh errors if credentials are invalid
        sms, init_error = initialize_africastalking()
        
        if not sms:
            return False, init_error or "SMS service not properly initialized"

        # Remove any duplicates and invalid numbers
        phone_numbers = list(set(filter(None, phone_numbers)))
        
        if not phone_numbers:
            return False, "No valid phone numbers provided"
            
        # Format all numbers to international format
        formatted_numbers = []
        for num in phone_numbers:
            try:
                formatted = format_phone_number(num)
                formatted_numbers.append(formatted)
            except Exception as e:
                logger.warning(f"Failed to format phone number {num}: {str(e)}")
                continue
        
        if not formatted_numbers:
            return False, "No valid phone numbers after formatting"
        
        # Log attempt
        logger.info(f"Attempting to send SMS to {len(formatted_numbers)} recipients")
        logger.info(f"Numbers: {', '.join(formatted_numbers[:5])}{'...' if len(formatted_numbers) > 5 else ''}")
        
        # Send the message - sender ID is optional
        try:
            sender_id = getattr(settings, 'SMS_SENDER_ID', None)
        except AttributeError:
            sender_id = None
        
        # If sender_id is not set, is None, or is empty string, send without it
        if sender_id and isinstance(sender_id, str) and sender_id.strip():
            logger.info(f"Using sender ID: {sender_id}")
            response = sms.send(
                message,
                formatted_numbers,
                sender_id.strip()
            )
        else:
            logger.info("Sending SMS without sender ID (using default)")
            # Send without sender ID - Africa's Talking will use default
            response = sms.send(
                message,
                formatted_numbers
            )
        
        # Log full response for debugging
        logger.info(f"SMS API Response: {response}")
        
        # Check response structure
        if response and isinstance(response, dict):
            # Check for error in response
            if 'errorMessage' in response:
                error_msg = response.get('errorMessage', 'Unknown error')
                logger.error(f"Africa's Talking API Error: {error_msg}")
                return False, f"API Error: {error_msg}"
            
            # Check SMSMessageData structure
            if 'SMSMessageData' in response:
                message_data = response['SMSMessageData']
                
                # Check for error in message data
                if 'Message' in message_data and 'error' in message_data['Message'].lower():
                    error_msg = message_data.get('Message', 'Unknown error')
                    logger.error(f"Africa's Talking Error: {error_msg}")
                    return False, f"Error: {error_msg}"
                
                if 'Recipients' in message_data and message_data['Recipients']:
                    successful = [
                        recipient for recipient in message_data['Recipients']
                        if recipient.get('status') == 'Success'
                    ]
                    failed = [
                        recipient for recipient in message_data['Recipients']
                        if recipient.get('status') != 'Success'
                    ]
                    
                    if successful:
                        logger.info(f"Successfully sent to {len(successful)} recipients")
                        if failed:
                            logger.warning(f"Failed to send to {len(failed)} recipients")
                        return True, response
                    else:
                        # All failed - get error messages
                        error_messages = [
                            rec.get('statusDescription', rec.get('status', 'Unknown error'))
                            for rec in failed
                        ]
                        error_msg = '; '.join(set(error_messages[:3]))  # Show first 3 unique errors
                        logger.error(f"All SMS failed: {error_msg}")
                        
                        # Provide helpful messages for common errors
                        environment = getattr(settings, 'AFRICASTALKING_ENVIRONMENT', 'production')
                        
                        if 'UserInBlacklist' in error_msg or 'blacklist' in error_msg.lower():
                            if environment == 'sandbox':
                                return False, f"Failed to send SMS: Phone number is not whitelisted. In sandbox mode, you can only send to verified/test numbers. Please add the number to your sandbox test numbers in your Africa's Talking dashboard."
                            else:
                                phone_num = formatted_numbers[0] if formatted_numbers else 'unknown'
                                return False, f"Failed to send SMS to {phone_num}: The recipient has opted out or the number is blocked. They need to opt back in by dialing *456*9# on their phone, selecting 'Marketing messages', and choosing to 'Activate all promo messages'."
                        
                        return False, f"Failed to send SMS: {error_msg}"
                else:
                    logger.warning("No recipients in response")
                    return False, "No recipients in API response"
            else:
                logger.warning(f"Unexpected response structure: {response}")
                return False, "Unexpected response format from API"
        else:
            logger.error(f"Invalid response from API: {response}")
            return False, "Invalid response from SMS service"
        
    except AfricasTalkingException as e:
        error_msg = str(e)
        logger.error(f"Africa's Talking Exception: {error_msg}")
        if 'authentication' in error_msg.lower() or 'invalid' in error_msg.lower():
            return False, f"Invalid API credentials: {error_msg}. Please verify your username '{settings.AFRICASTALKING_USERNAME}' and API key in settings.py match your Africa's Talking dashboard."
        return False, f"Africa's Talking Error: {error_msg}"
    except Exception as e:
        error_msg = str(e)
        logger.error(f"SMS sending failed: {error_msg}", exc_info=True)
        if 'authentication' in error_msg.lower() or 'unauthorized' in error_msg.lower():
            return False, "Invalid API credentials. Please check your Africa's Talking settings."
        return False, f"Failed to send SMS: {error_msg}"

def format_phone_number(phone):
    """
    Format phone number to international format
    Example: convert "0712345678" to "+254712345678"
    """
    phone = str(phone).strip()
    
    # Remove any spaces or special characters
    phone = ''.join(filter(str.isdigit, phone))
    
    # Handle Kenyan numbers
    if phone.startswith('0'):
        phone = '254' + phone[1:]
    elif phone.startswith('7') or phone.startswith('1'):
        phone = '254' + phone
    elif not phone.startswith('254'):
        phone = '254' + phone
    
    return '+' + phone
