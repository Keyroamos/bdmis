import React, { useState, useEffect } from 'react';
import {
    User, Lock, Bell, Globe, Palette, Database, Shield, Save, FileText, MapPin, Plus, Trash2, Camera, Building2
} from 'lucide-react';
import Button from '../components/ui/Button';
import Input from '../components/ui/Input';
import { useSchool } from '../context/SchoolContext';
import axios from 'axios';

const SettingsSection = ({ title, icon: Icon, children }) => (
    <div className="bg-white dark:bg-slate-900 rounded-2xl shadow-sm border border-slate-100 dark:border-slate-800 overflow-hidden">
        <div className="px-6 py-4 border-b border-slate-100 dark:border-slate-800 flex items-center gap-3">
            <div className="p-2 bg-slate-50 dark:bg-slate-800 rounded-lg">
                <Icon size={20} className="text-slate-600 dark:text-slate-400" />
            </div>
            <h3 className="font-semibold text-slate-900 dark:text-white">{title}</h3>
        </div>
        <div className="p-6">
            {children}
        </div>
    </div>
);

const Settings = () => {
    const user = JSON.parse(localStorage.getItem('user') || '{}');
    const { fetchConfig: refreshGlobalConfig, updateConfig } = useSchool();
    const [activeTab, setActiveTab] = useState('profile');
    const [loading, setLoading] = useState(false);
    const [configLoading, setConfigLoading] = useState(true);
    const [message, setMessage] = useState(null);
    const [formData, setFormData] = useState({
        first_name: user.first_name || '',
        last_name: user.last_name || '',
        email: user.email || '',
        current_password: '',
        new_password: '',
        confirm_password: '',
        // School config
        school_name: '',
        school_code: '',
        school_email: '',
        school_phone: '',
        school_address: '',
        admission_number_format: '',
        admission_counter: 0,
        school_logo: null,
        school_logo_preview: null,
        school_logo_file: null
    });
    const [branches, setBranches] = useState([]);
    const [newBranch, setNewBranch] = useState({ name: '', address: '', phone: '' });

    const fetchBranches = async () => {
        try {
            const response = await axios.get('/api/branches/');
            setBranches(response.data.branches || []);
        } catch (error) {
            console.error('Error fetching branches:', error);
        }
    };

    const handleAddBranch = async () => {
        if (!newBranch.name) return;
        try {
            await axios.post('/api/branches/', newBranch);
            setNewBranch({ name: '', address: '', phone: '' });
            fetchBranches();
            setMessage({ type: 'success', text: 'Branch added successfully' });
            setTimeout(() => setMessage(null), 3000);
        } catch (error) {
            setMessage({ type: 'error', text: error.response?.data?.error || 'Failed to add branch' });
            setTimeout(() => setMessage(null), 3000);
        }
    };

    const handleDeleteBranch = async (id) => {
        if (!window.confirm('Are you sure you want to delete this branch?')) return;
        try {
            await axios.delete(`/api/branches/${id}/`);
            fetchBranches();
            setMessage({ type: 'success', text: 'Branch deleted successfully' });
            setTimeout(() => setMessage(null), 3000);
        } catch (error) {
            console.error('Error deleting branch:', error);
            setMessage({ type: 'error', text: 'Failed to delete branch' });
            setTimeout(() => setMessage(null), 3000);
        }
    };

    useEffect(() => {
        if (activeTab === 'branches') {
            fetchBranches();
        }
    }, [activeTab]);

    useEffect(() => {
        // Fetch school configuration
        const fetchConfig = async () => {
            setConfigLoading(true);
            try {
                const response = await axios.get('/api/config/');
                const config = response.data?.config || {};
                setFormData(prev => ({
                    ...prev,
                    school_name: config?.school_name || '',
                    school_code: config?.school_code || '',
                    school_email: config?.school_email || '',
                    school_phone: config?.school_phone || '',
                    school_address: config?.school_address || '',
                    admission_number_format: config?.admission_number_format || '',
                    admission_counter: config?.admission_counter || 0,
                    school_logo: config?.school_logo || null,
                }));
            } catch (error) {
                console.error('Error fetching config:', error);
            } finally {
                setConfigLoading(false);
            }
        };
        fetchConfig();
    }, []);

    const handleChange = (e) => {
        setFormData(prev => ({
            ...prev,
            [e.target.name]: e.target.value
        }));
    };

    const handleSaveProfile = () => {
        // TODO: Implement profile update API call
        console.log('Saving profile:', formData);
        setMessage({ type: 'success', text: 'Profile updated successfully!' });
        setTimeout(() => setMessage(null), 3000);
    };

    const handleChangePassword = () => {
        // TODO: Implement password change API call
        console.log('Changing password');
        setMessage({ type: 'success', text: 'Password changed successfully!' });
        setTimeout(() => setMessage(null), 3000);
    };

    const handleSaveSchoolConfig = async () => {
        setLoading(true);
        try {
            const data = new FormData();
            data.append('school_name', formData.school_name);
            data.append('school_code', formData.school_code);
            data.append('school_email', formData.school_email);
            data.append('school_phone', formData.school_phone);
            data.append('school_address', formData.school_address);
            data.append('admission_number_format', formData.admission_number_format);

            if (formData.school_logo_file) {
                data.append('school_logo', formData.school_logo_file);
            }

            const response = await axios.post('/api/config/update/', data);

            // Check for success and existence of config in any of the common keys
            const savedConfig = response.data?.config || response.data?.saved_data || response.data?.configuration;

            if (response.data?.success && savedConfig) {
                // 1. Update Global Context
                updateConfig(savedConfig);

                // 2. Update Local State (formData)
                setFormData(prev => ({
                    ...prev,
                    school_name: savedConfig.school_name || '',
                    school_code: savedConfig.school_code || '',
                    school_email: savedConfig.school_email || '',
                    school_phone: savedConfig.school_phone || '',
                    school_address: savedConfig.school_address || '',
                    admission_number_format: savedConfig.admission_number_format || '',
                    admission_counter: savedConfig.admission_counter || 0,
                    school_logo: savedConfig.school_logo || null,
                    school_logo_preview: null,
                    school_logo_file: null
                }));

                setMessage({ type: 'success', text: 'Institutional settings saved successfully!' });
            } else {
                console.warn('Config save returned unusual data:', response.data);
                if (response.data?.success) {
                    await refreshGlobalConfig();
                    setMessage({ type: 'success', text: 'Institutional settings saved!' });
                } else {
                    const errorDetail = response.data?.error || response.data?.message || 'Sync failed';
                    setMessage({ type: 'error', text: `Settings saved but sync issue: ${errorDetail}` });
                }
            }

            setTimeout(() => setMessage(null), 5000);
        } catch (error) {
            console.error('Error saving config:', error);
            setMessage({ type: 'error', text: error.response?.data?.error || 'Server error while saving configuration' });
            setTimeout(() => setMessage(null), 5000);
        } finally {
            setLoading(false);
        }
    };

    const getAdmissionNumberPreview = () => {
        const format = formData.admission_number_format || '{SCHOOL_CODE}/{YEAR}/{COUNTER:04d}';
        const schoolCode = formData.school_code || 'EDU';
        const year = new Date().getFullYear();
        const counter = (formData.admission_counter || 0) + 1;

        let preview = format;
        preview = preview.replace('{SCHOOL_CODE}', schoolCode);
        preview = preview.replace('{YEAR}', year.toString());
        preview = preview.replace('{COUNTER:04d}', counter.toString().padStart(4, '0'));
        preview = preview.replace('{COUNTER:05d}', counter.toString().padStart(5, '0'));
        preview = preview.replace('{COUNTER:03d}', counter.toString().padStart(3, '0'));
        preview = preview.replace('{COUNTER}', counter.toString());
        preview = preview.replace('{GRADE}', 'Grade1');

        return preview;
    };

    const tabs = [
        { id: 'profile', label: 'Profile', icon: User },
        { id: 'security', label: 'Security', icon: Shield },
        { id: 'notifications', label: 'Notifications', icon: Bell },
        { id: 'appearance', label: 'Appearance', icon: Palette },
        { id: 'branches', label: 'Branches', icon: MapPin },
        { id: 'admission', label: 'Admission', icon: FileText },
        { id: 'system', label: 'System', icon: Database }
    ];

    return (
        <div className="p-6 max-w-7xl mx-auto space-y-6">
            {/* Header */}
            <div>
                <h1 className="text-2xl font-bold text-slate-900 dark:text-white">Settings</h1>
                <p className="text-slate-500 dark:text-slate-400">Manage your account and application preferences</p>
            </div>

            {/* Success/Error Message */}
            {message && (
                <div className={`p-4 rounded-xl ${message.type === 'success' ? 'bg-green-50 text-green-700 border border-green-200' : 'bg-red-50 text-red-700 border border-red-200'
                    }`}>
                    {message.text}
                </div>
            )}

            {/* Tabs */}
            <div className="bg-white dark:bg-slate-900 rounded-2xl shadow-sm border border-slate-100 dark:border-slate-800 p-2">
                <div className="flex gap-2 overflow-x-auto">
                    {tabs.map(tab => (
                        <button
                            key={tab.id}
                            onClick={() => setActiveTab(tab.id)}
                            className={`flex items-center gap-2 px-4 py-2 rounded-lg text-sm font-medium transition-colors whitespace-nowrap ${activeTab === tab.id
                                ? 'bg-primary-50 dark:bg-primary-900/20 text-primary-700 dark:text-primary-400'
                                : 'text-slate-600 dark:text-slate-400 hover:bg-slate-50 dark:hover:bg-slate-800'
                                }`}
                        >
                            <tab.icon size={16} />
                            {tab.label}
                        </button>
                    ))}
                </div>
            </div>

            {/* Profile Settings */}
            {activeTab === 'profile' && (
                <div className="space-y-6">
                    <SettingsSection title="Profile Information" icon={User}>
                        <div className="space-y-4">
                            <div className="flex items-center gap-6 mb-6">
                                <div className="h-20 w-20 rounded-full bg-primary-100 flex items-center justify-center text-primary-700 font-bold text-2xl">
                                    {(user.first_name?.[0] || 'U')}{(user.last_name?.[0] || '')}
                                </div>
                                <div>
                                    <Button variant="secondary" size="sm">Change Photo</Button>
                                    <p className="text-xs text-slate-500 mt-2">JPG, PNG or GIF. Max size 2MB</p>
                                </div>
                            </div>

                            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <Input
                                    label="First Name"
                                    name="first_name"
                                    value={formData.first_name}
                                    onChange={handleChange}
                                />
                                <Input
                                    label="Last Name"
                                    name="last_name"
                                    value={formData.last_name}
                                    onChange={handleChange}
                                />
                            </div>

                            <Input
                                type="email"
                                label="Email Address"
                                name="email"
                                value={formData.email}
                                onChange={handleChange}
                            />

                            <div className="flex justify-end pt-4">
                                <Button onClick={handleSaveProfile}>
                                    <Save size={18} className="mr-2" />
                                    Save Changes
                                </Button>
                            </div>
                        </div>
                    </SettingsSection>
                </div>
            )}

            {/* Security Settings */}
            {activeTab === 'security' && (
                <div className="space-y-6">
                    <SettingsSection title="Change Password" icon={Lock}>
                        <div className="space-y-4">
                            <Input
                                type="password"
                                label="Current Password"
                                name="current_password"
                                value={formData.current_password}
                                onChange={handleChange}
                            />
                            <Input
                                type="password"
                                label="New Password"
                                name="new_password"
                                value={formData.new_password}
                                onChange={handleChange}
                            />
                            <Input
                                type="password"
                                label="Confirm New Password"
                                name="confirm_password"
                                value={formData.confirm_password}
                                onChange={handleChange}
                            />

                            <div className="flex justify-end pt-4">
                                <Button onClick={handleChangePassword}>
                                    <Lock size={18} className="mr-2" />
                                    Update Password
                                </Button>
                            </div>
                        </div>
                    </SettingsSection>

                    <SettingsSection title="Two-Factor Authentication" icon={Shield}>
                        <div className="flex items-center justify-between">
                            <div>
                                <p className="font-medium text-slate-900">Enable 2FA</p>
                                <p className="text-sm text-slate-500">Add an extra layer of security to your account</p>
                            </div>
                            <label className="relative inline-flex items-center cursor-pointer">
                                <input type="checkbox" className="sr-only peer" />
                                <div className="w-11 h-6 bg-slate-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-primary-100 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-slate-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary-600"></div>
                            </label>
                        </div>
                    </SettingsSection>
                </div>
            )}

            {/* Notifications Settings */}
            {activeTab === 'notifications' && (
                <SettingsSection title="Notification Preferences" icon={Bell}>
                    <div className="space-y-4">
                        {[
                            { id: 'email_notifications', label: 'Email Notifications', description: 'Receive email updates about important events' },
                            { id: 'sms_notifications', label: 'SMS Notifications', description: 'Get text messages for urgent alerts' },
                            { id: 'payment_alerts', label: 'Payment Alerts', description: 'Notify when payments are received' },
                            { id: 'attendance_alerts', label: 'Attendance Alerts', description: 'Daily attendance summary reports' }
                        ].map(item => (
                            <div key={item.id} className="flex items-center justify-between py-3 border-b border-slate-100 last:border-0">
                                <div>
                                    <p className="font-medium text-slate-900">{item.label}</p>
                                    <p className="text-sm text-slate-500">{item.description}</p>
                                </div>
                                <label className="relative inline-flex items-center cursor-pointer">
                                    <input type="checkbox" className="sr-only peer" defaultChecked />
                                    <div className="w-11 h-6 bg-slate-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-primary-100 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-slate-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary-600"></div>
                                </label>
                            </div>
                        ))}
                    </div>
                </SettingsSection>
            )}

            {/* Appearance Settings */}
            {activeTab === 'appearance' && (
                <div className="space-y-6">
                    <SettingsSection title="Theme Preferences" icon={Palette}>
                        <div className="space-y-6">
                            <div>
                                <label className="block text-sm font-medium text-slate-700 mb-4">Choose Theme</label>
                                <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                                    {/* Light Theme */}
                                    <button
                                        onClick={() => {
                                            localStorage.setItem('theme', 'light');
                                            document.documentElement.classList.remove('dark');
                                            setMessage({ type: 'success', text: 'Light theme applied!' });
                                            setTimeout(() => setMessage(null), 2000);
                                        }}
                                        className={`p-4 border-2 rounded-xl transition-all hover:scale-105 ${(!localStorage.getItem('theme') || localStorage.getItem('theme') === 'light')
                                            ? 'border-primary-500 bg-primary-50'
                                            : 'border-slate-200 hover:border-primary-300'
                                            }`}
                                    >
                                        <div className="h-24 rounded-lg mb-3 bg-white border-2 border-slate-200 flex items-center justify-center">
                                            <div className="text-center">
                                                <div className="w-12 h-12 bg-slate-100 rounded-lg mx-auto mb-2"></div>
                                                <div className="space-y-1">
                                                    <div className="h-2 w-16 bg-slate-200 rounded mx-auto"></div>
                                                    <div className="h-2 w-12 bg-slate-200 rounded mx-auto"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <p className="text-sm font-semibold text-slate-900">Light</p>
                                        <p className="text-xs text-slate-500 mt-1">Clean and bright interface</p>
                                    </button>

                                    {/* Dark Theme */}
                                    <button
                                        onClick={() => {
                                            localStorage.setItem('theme', 'dark');
                                            document.documentElement.classList.add('dark');
                                            setMessage({ type: 'success', text: 'Dark theme applied!' });
                                            setTimeout(() => setMessage(null), 2000);
                                        }}
                                        className={`p-4 border-2 rounded-xl transition-all hover:scale-105 ${localStorage.getItem('theme') === 'dark'
                                            ? 'border-primary-500 bg-primary-50'
                                            : 'border-slate-200 hover:border-primary-300'
                                            }`}
                                    >
                                        <div className="h-24 rounded-lg mb-3 bg-slate-900 border-2 border-slate-700 flex items-center justify-center">
                                            <div className="text-center">
                                                <div className="w-12 h-12 bg-slate-800 rounded-lg mx-auto mb-2"></div>
                                                <div className="space-y-1">
                                                    <div className="h-2 w-16 bg-slate-700 rounded mx-auto"></div>
                                                    <div className="h-2 w-12 bg-slate-700 rounded mx-auto"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <p className="text-sm font-semibold text-slate-900">Dark</p>
                                        <p className="text-xs text-slate-500 mt-1">Easy on the eyes</p>
                                    </button>

                                    {/* Auto Theme */}
                                    <button
                                        onClick={() => {
                                            localStorage.setItem('theme', 'auto');
                                            // Check system preference
                                            if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
                                                document.documentElement.classList.add('dark');
                                            } else {
                                                document.documentElement.classList.remove('dark');
                                            }
                                            setMessage({ type: 'success', text: 'Auto theme applied!' });
                                            setTimeout(() => setMessage(null), 2000);
                                        }}
                                        className={`p-4 border-2 rounded-xl transition-all hover:scale-105 ${localStorage.getItem('theme') === 'auto'
                                            ? 'border-primary-500 bg-primary-50'
                                            : 'border-slate-200 hover:border-primary-300'
                                            }`}
                                    >
                                        <div className="h-24 rounded-lg mb-3 bg-gradient-to-br from-white via-slate-200 to-slate-900 border-2 border-slate-300 flex items-center justify-center">
                                            <div className="text-center">
                                                <div className="w-12 h-12 bg-white/50 backdrop-blur rounded-lg mx-auto mb-2"></div>
                                                <div className="space-y-1">
                                                    <div className="h-2 w-16 bg-white/70 rounded mx-auto"></div>
                                                    <div className="h-2 w-12 bg-white/70 rounded mx-auto"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <p className="text-sm font-semibold text-slate-900">Auto</p>
                                        <p className="text-xs text-slate-500 mt-1">Follows system settings</p>
                                    </button>
                                </div>
                            </div>

                            {/* Current Theme Info */}
                            <div className="bg-blue-50 border border-blue-200 rounded-xl p-4">
                                <div className="flex items-start gap-3">
                                    <div className="p-2 bg-blue-500 rounded-lg">
                                        <Palette className="text-white" size={18} />
                                    </div>
                                    <div>
                                        <p className="text-sm font-semibold text-blue-900">Current Theme</p>
                                        <p className="text-xs text-blue-700 mt-1">
                                            {localStorage.getItem('theme') === 'dark' ? 'Dark Mode' :
                                                localStorage.getItem('theme') === 'auto' ? 'Auto (System Preference)' :
                                                    'Light Mode'}
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </SettingsSection>

                    <SettingsSection title="Accent Color" icon={Palette}>
                        <div className="space-y-4">
                            <label className="block text-sm font-medium text-slate-700 mb-3">Choose Accent Color</label>
                            <div className="flex flex-wrap gap-4">
                                {[
                                    { name: 'Blue', color: 'bg-blue-500', value: 'blue' },
                                    { name: 'Green', color: 'bg-green-500', value: 'green' },
                                    { name: 'Violet', color: 'bg-violet-500', value: 'violet' },
                                    { name: 'Red', color: 'bg-red-500', value: 'red' },
                                    { name: 'Orange', color: 'bg-orange-500', value: 'orange' },
                                    { name: 'Pink', color: 'bg-pink-500', value: 'pink' },
                                    { name: 'Indigo', color: 'bg-indigo-500', value: 'indigo' },
                                    { name: 'Teal', color: 'bg-teal-500', value: 'teal' }
                                ].map(({ name, color, value }) => (
                                    <button
                                        key={value}
                                        onClick={() => {
                                            localStorage.setItem('accentColor', value);
                                            setMessage({ type: 'success', text: `${name} accent applied!` });
                                            setTimeout(() => setMessage(null), 2000);
                                        }}
                                        className="group relative"
                                        title={name}
                                    >
                                        <div className={`w-12 h-12 rounded-full ${color} hover:scale-110 transition-transform shadow-lg ${localStorage.getItem('accentColor') === value ? 'ring-4 ring-offset-2 ring-slate-400' : ''
                                            }`}></div>
                                        <span className="absolute -bottom-6 left-1/2 -translate-x-1/2 text-xs text-slate-600 opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap">
                                            {name}
                                        </span>
                                    </button>
                                ))}
                            </div>
                            <p className="text-xs text-slate-500 mt-4">
                                Note: Accent color changes will be applied in future updates
                            </p>
                        </div>
                    </SettingsSection>
                </div>
            )}

            {/* Admission Settings */}
            {activeTab === 'admission' && (
                <SettingsSection title="Admission Number Configuration" icon={FileText}>
                    <div className="space-y-6">
                        <div>
                            <label className="block text-sm font-medium text-slate-700 mb-2">
                                Format Template
                            </label>
                            <Input
                                name="admission_number_format"
                                value={formData.admission_number_format || ''}
                                onChange={handleChange}
                                placeholder="{SCHOOL_CODE}/{YEAR}/{COUNTER:04d}"
                            />
                            <p className="text-xs text-slate-500 mt-2">
                                Available placeholders: <code className="bg-slate-100 px-1 py-0.5 rounded">{'{' + 'SCHOOL_CODE' + '}'}</code>,
                                <code className="bg-slate-100 px-1 py-0.5 rounded ml-1">{'{' + 'YEAR' + '}'}</code>,
                                <code className="bg-slate-100 px-1 py-0.5 rounded ml-1">{'{' + 'COUNTER:04d' + '}'}</code>,
                                <code className="bg-slate-100 px-1 py-0.5 rounded ml-1">{'{' + 'GRADE' + '}'}</code>
                            </p>
                        </div>

                        {/* Live Preview */}
                        <div className="bg-gradient-to-br from-blue-50 to-indigo-50 border-2 border-blue-200 rounded-2xl p-6">
                            <div className="flex items-center gap-3 mb-3">
                                <div className="p-2 bg-blue-500 rounded-lg">
                                    <FileText className="text-white" size={20} />
                                </div>
                                <p className="text-sm font-semibold text-blue-900">Live Preview</p>
                            </div>
                            <div className="bg-white rounded-xl p-4 border-2 border-blue-300">
                                <p className="text-xs text-slate-500 mb-1">Next Admission Number:</p>
                                <div className="font-mono text-2xl font-bold text-blue-700">
                                    {getAdmissionNumberPreview()}
                                </div>
                            </div>
                            <p className="text-xs text-blue-700 mt-3 flex items-center gap-1">
                                <span className="inline-block w-2 h-2 bg-green-500 rounded-full animate-pulse"></span>
                                This format will be applied to all new student registrations
                            </p>
                        </div>

                        {/* Format Examples */}
                        <div className="bg-slate-50 rounded-2xl p-6 border border-slate-200">
                            <p className="text-sm font-semibold text-slate-700 mb-4 flex items-center gap-2">
                                <span className="inline-block w-1 h-4 bg-primary-500 rounded"></span>
                                Format Examples
                            </p>
                            <div className="space-y-3">
                                <div className="flex items-center justify-between p-3 bg-white rounded-lg border border-slate-200">
                                    <code className="text-slate-600 text-sm">{'{' + 'SCHOOL_CODE' + '}'}/{'{' + 'YEAR' + '}'}/{'{' + 'COUNTER:04d' + '}'}</code>
                                    <span className="text-slate-400 mx-3">→</span>
                                    <span className="font-mono text-slate-900 font-semibold">EDU/2024/0001</span>
                                </div>
                                <div className="flex items-center justify-between p-3 bg-white rounded-lg border border-slate-200">
                                    <code className="text-slate-600 text-sm">{'{' + 'YEAR' + '}'}-{'{' + 'SCHOOL_CODE' + '}'}-{'{' + 'COUNTER:05d' + '}'}</code>
                                    <span className="text-slate-400 mx-3">→</span>
                                    <span className="font-mono text-slate-900 font-semibold">2024-EDU-00001</span>
                                </div>
                                <div className="flex items-center justify-between p-3 bg-white rounded-lg border border-slate-200">
                                    <code className="text-slate-600 text-sm">{'{' + 'SCHOOL_CODE' + '}'}{'{' + 'YEAR' + '}'}{'{' + 'COUNTER:03d' + '}'}</code>
                                    <span className="text-slate-400 mx-3">→</span>
                                    <span className="font-mono text-slate-900 font-semibold">EDU2024001</span>
                                </div>
                            </div>
                        </div>

                        {/* Placeholder Guide */}
                        <div className="bg-amber-50 border border-amber-200 rounded-xl p-4">
                            <p className="text-sm font-semibold text-amber-900 mb-3">Placeholder Guide:</p>
                            <div className="space-y-2 text-sm text-amber-800">
                                <div className="flex gap-3">
                                    <code className="bg-amber-100 px-2 py-0.5 rounded font-mono">{'{' + 'SCHOOL_CODE' + '}'}</code>
                                    <span>- Your school&apos;s unique code (e.g., EDU, ABC)</span>
                                </div>
                                <div className="flex gap-3">
                                    <code className="bg-amber-100 px-2 py-0.5 rounded font-mono">{'{' + 'YEAR' + '}'}</code>
                                    <span>- Current year (e.g., 2024, 2025)</span>
                                </div>
                                <div className="flex gap-3">
                                    <code className="bg-amber-100 px-2 py-0.5 rounded font-mono">{'{' + 'COUNTER:04d' + '}'}</code>
                                    <span>- Auto-incrementing number with 4-digit padding (0001, 0002...)</span>
                                </div>
                                <div className="flex gap-3">
                                    <code className="bg-amber-100 px-2 py-0.5 rounded font-mono">{'{' + 'GRADE' + '}'}</code>
                                    <span>- Student&apos;s grade/class (optional)</span>
                                </div>
                            </div>
                        </div>

                        <div className="flex justify-end pt-4 border-t border-slate-200">
                            <Button onClick={handleSaveSchoolConfig} isLoading={loading}>
                                <Save size={18} className="mr-2" />
                                Save Admission Format
                            </Button>
                        </div>
                    </div>
                </SettingsSection>
            )}

            {/* System Settings */}
            {activeTab === 'system' && (
                <div className="space-y-6">
                    <SettingsSection title="School Information" icon={Globe}>
                        {configLoading ? (
                            <div className="flex flex-col items-center justify-center py-12 space-y-4">
                                <div className="animate-spin rounded-full h-10 w-10 border-b-2 border-primary-600"></div>
                                <p className="text-sm font-medium text-slate-500">Loading school configuration...</p>
                            </div>
                        ) : (
                            <div className="space-y-6">
                                {/* Logo Upload Section */}
                                <div className="flex flex-col sm:flex-row items-center gap-6 pb-6 border-b border-slate-100 dark:border-slate-800">
                                    <div className="relative group">
                                        <div className="h-24 w-24 rounded-2xl bg-slate-100 dark:bg-slate-800 border-2 border-dashed border-slate-300 dark:border-slate-700 flex items-center justify-center overflow-hidden transition-all group-hover:border-primary-500">
                                            {formData.school_logo_preview || formData.school_logo ? (
                                                <img
                                                    src={formData.school_logo_preview || formData.school_logo}
                                                    alt="School Logo"
                                                    className="h-full w-full object-contain"
                                                />
                                            ) : (
                                                <Building2 className="text-slate-400" size={32} />
                                            )}
                                        </div>
                                        <label className="absolute -bottom-2 -right-2 p-2 bg-primary-600 hover:bg-primary-700 text-white rounded-xl shadow-lg cursor-pointer transition-all hover:scale-110">
                                            <Camera size={14} />
                                            <input
                                                type="file"
                                                className="hidden"
                                                accept="image/*"
                                                onChange={(e) => {
                                                    const file = e.target.files[0];
                                                    if (file) {
                                                        const reader = new FileReader();
                                                        reader.onloadend = () => {
                                                            setFormData(prev => ({
                                                                ...prev,
                                                                school_logo_file: file,
                                                                school_logo_preview: reader.result
                                                            }));
                                                        };
                                                        reader.readAsDataURL(file);
                                                    }
                                                }}
                                            />
                                        </label>
                                    </div>
                                    <div className="text-center sm:text-left">
                                        <h4 className="font-bold text-slate-900 dark:text-white">Institution Logo</h4>
                                        <p className="text-sm text-slate-500 dark:text-slate-400 mt-1 max-w-xs">
                                            This logo will appear on all sidebars, login pages, and official receipts.
                                            Recommended size: 512x512px.
                                        </p>
                                    </div>
                                </div>

                                <div className="space-y-4">
                                    <Input
                                        label="School Name"
                                        name="school_name"
                                        value={formData.school_name || ''}
                                        onChange={handleChange}
                                    />
                                    <Input
                                        label="School Code"
                                        name="school_code"
                                        value={formData.school_code || ''}
                                        onChange={handleChange}
                                    />
                                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                                        <Input
                                            label="Phone Number"
                                            name="school_phone"
                                            value={formData.school_phone || ''}
                                            onChange={handleChange}
                                        />
                                        <Input
                                            type="email"
                                            label="School Email"
                                            name="school_email"
                                            value={formData.school_email || ''}
                                            onChange={handleChange}
                                        />
                                    </div>
                                    <div className="space-y-1">
                                        <label className="block text-sm font-medium text-slate-700 dark:text-slate-300">
                                            School Address
                                        </label>
                                        <textarea
                                            name="school_address"
                                            value={formData.school_address || ''}
                                            onChange={handleChange}
                                            className="w-full px-4 py-2 bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-xl focus:ring-2 focus:ring-primary-500/20 focus:border-primary-500 transition-all outline-none min-h-[100px]"
                                            placeholder="Enter school physical address..."
                                        />
                                    </div>
                                    <div className="flex justify-end pt-4">
                                        <Button onClick={handleSaveSchoolConfig}>
                                            <Save size={18} className="mr-2" />
                                            Save Changes
                                        </Button>
                                    </div>
                                </div>
                            </div>
                        )}
                    </SettingsSection>

                    <SettingsSection title="Database & Backup" icon={Database}>
                        <div className="space-y-4">
                            <div className="flex items-center justify-between py-3 border-b border-slate-100">
                                <div>
                                    <p className="font-medium text-slate-900">Automatic Backups</p>
                                    <p className="text-sm text-slate-500">Daily database backups at 2:00 AM</p>
                                </div>
                                <label className="relative inline-flex items-center cursor-pointer">
                                    <input type="checkbox" className="sr-only peer" defaultChecked />
                                    <div className="w-11 h-6 bg-slate-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-primary-100 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-slate-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary-600"></div>
                                </label>
                            </div>
                            <div className="pt-2">
                                <Button variant="secondary">
                                    <Database size={18} className="mr-2" />
                                    Backup Now
                                </Button>
                            </div>
                        </div>
                    </SettingsSection>
                </div >
            )}

            {/* Branches Settings */}
            {
                activeTab === 'branches' && (
                    <div className="space-y-6">
                        <SettingsSection title="Manage Branches" icon={MapPin}>
                            <div className="space-y-6">
                                <div className="grid grid-cols-1 md:grid-cols-3 gap-4 bg-slate-50 dark:bg-slate-800 p-4 rounded-xl border border-slate-100 dark:border-slate-700">
                                    <Input
                                        placeholder="Branch Name"
                                        value={newBranch.name}
                                        onChange={(e) => setNewBranch({ ...newBranch, name: e.target.value })}
                                    />
                                    <Input
                                        placeholder="Address (Optional)"
                                        value={newBranch.address}
                                        onChange={(e) => setNewBranch({ ...newBranch, address: e.target.value })}
                                    />
                                    <div className="flex gap-2">
                                        <Input
                                            placeholder="Phone (Optional)"
                                            value={newBranch.phone}
                                            onChange={(e) => setNewBranch({ ...newBranch, phone: e.target.value })}
                                        />
                                        <Button onClick={handleAddBranch} disabled={!newBranch.name}>
                                            <Plus size={18} />
                                        </Button>
                                    </div>
                                </div>

                                <div className="space-y-3">
                                    <h4 className="font-medium text-slate-900 dark:text-white">Existing Branches</h4>
                                    {branches.length === 0 ? (
                                        <p className="text-slate-500 italic">No branches added yet.</p>
                                    ) : (
                                        <div className="grid gap-3">
                                            {branches.map(branch => (
                                                <div key={branch.id} className="flex justify-between items-center p-4 bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-700 rounded-xl">
                                                    <div>
                                                        <p className="font-bold text-slate-900 dark:text-white">{branch.name}</p>
                                                        <div className="flex gap-4 text-sm text-slate-500">
                                                            {branch.address && <span>{branch.address}</span>}
                                                            {branch.phone && <span>{branch.phone}</span>}
                                                        </div>
                                                    </div>
                                                    <Button variant="ghost" className="text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20" onClick={() => handleDeleteBranch(branch.id)}>
                                                        <Trash2 size={18} />
                                                    </Button>
                                                </div>
                                            ))}
                                        </div>
                                    )}
                                </div>
                            </div>
                        </SettingsSection>
                    </div>
                )
            }
        </div >
    );
};

export default Settings;
