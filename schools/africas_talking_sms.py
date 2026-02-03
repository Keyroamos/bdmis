"""
Africa's Talking SMS Service
Correct Django implementation for sending live SMS
"""
import africastalking
from django.conf import settings
import logging

logger = logging.getLogger(__name__)

class AfricaTalkingSMS:
    """Service class for sending SMS via Africa's Talking"""
    
    def __init__(self):
        """Initialize Africa's Talking with credentials from settings"""
        try:
            username = getattr(settings, 'AFRICASTALKING_USERNAME', None) or getattr(settings, 'AT_USERNAME', None)
            api_key = getattr(settings, 'AFRICASTALKING_API_KEY', None) or getattr(settings, 'AT_API_KEY', None)
            
            if not username or not api_key:
                raise ValueError("Africa's Talking credentials not found in settings. Please set AFRICASTALKING_USERNAME and AFRICASTALKING_API_KEY")
            
            africastalking.initialize(username, api_key)
            self.sms = africastalking.SMS
            logger.info("Africa's Talking SMS service initialized successfully")
        except Exception as e:
            logger.error(f"Failed to initialize Africa's Talking: {str(e)}")
            raise
    
    def send_sms(self, phone, message, sender_id=None):
        """
        Send SMS to a single phone number
        
        Args:
            phone: Phone number in format "+2547XXXXXXX" or "07XXXXXXXX"
            message: SMS message text
            sender_id: Optional sender ID (must be approved in dashboard)
        
        Returns:
            dict: Response from Africa's Talking API
        """
        try:
            # Format phone number if needed
            phone = self._format_phone(phone)
            
            # Send SMS
            if sender_id:
                response = self.sms.send(
                    message,
                    [phone],
                    sender_id=sender_id
                )
            else:
                response = self.sms.send(
                    message,
                    [phone]
                )
            
            logger.info(f"SMS sent to {phone}: {response}")
            return response
        except Exception as e:
            error_msg = str(e)
            logger.error(f"Failed to send SMS to {phone}: {error_msg}")
            return {"error": error_msg}
    
    def send_bulk_sms(self, phone_numbers, message, sender_id=None):
        """
        Send SMS to multiple phone numbers
        
        Args:
            phone_numbers: List of phone numbers
            message: SMS message text
            sender_id: Optional sender ID
        
        Returns:
            dict: Response from Africa's Talking API
        """
        try:
            # Format all phone numbers
            formatted_numbers = [self._format_phone(phone) for phone in phone_numbers]
            
            # Remove duplicates
            formatted_numbers = list(set(formatted_numbers))
            
            # Send SMS
            if sender_id:
                response = self.sms.send(
                    message,
                    formatted_numbers,
                    sender_id=sender_id
                )
            else:
                response = self.sms.send(
                    message,
                    formatted_numbers
                )
            
            logger.info(f"Bulk SMS sent to {len(formatted_numbers)} recipients: {response}")
            return response
        except Exception as e:
            error_msg = str(e)
            logger.error(f"Failed to send bulk SMS: {error_msg}")
            return {"error": error_msg}
    
    def _format_phone(self, phone):
        """
        Format phone number to international format
        Example: "0712345678" -> "+254712345678"
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

