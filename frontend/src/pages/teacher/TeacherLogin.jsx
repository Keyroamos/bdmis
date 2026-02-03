import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Mail, Lock, LogIn, AlertCircle, BookOpen } from 'lucide-react';
import Button from '../../components/ui/Button';
import Input from '../../components/ui/Input';
import axios from 'axios';

const TeacherLogin = () => {
    const navigate = useNavigate();
    const [formData, setFormData] = useState({
        username: '',
        password: ''
    });
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        setError(null);

        try {
            const response = await axios.post('/api/auth/login/', formData);

            if (response.data.success) {
                // Store user data
                localStorage.setItem('user', JSON.stringify(response.data.user));

                // Check if user is a teacher
                if (response.data.user.role === 'teacher') {
                    // Redirect to the URL provided by backend, usually /teacher/{id}
                    // But we want to use our new generic portal route which will read from the user object or ID
                    // Let's use the ID to navigate to the dashboard
                    // The backend returns redirect_url: "/teacher/{id}"
                    // We'll replace that with our portal route
                    const teacherId = response.data.user.id; // Or extract from response
                    // Actually api_login returns user.id which is the User ID, not Teacher ID.
                    // But the redirect_url contains the Teacher ID.
                    // The redirect_url format is usually /teacher/PK
                    // We can use that or a dedicated portal route
                    navigate(response.data.redirect_url);
                } else {
                    setError('This portal is only for staff/teachers.');
                }
            } else {
                setError(response.data.error || 'Login failed');
            }
        } catch (err) {
            console.error(err);
            setError(err.response?.data?.error || 'Failed to connect to server');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="min-h-screen bg-slate-900 flex items-center justify-center p-4">
            <div className="max-w-md w-full bg-white dark:bg-slate-800 rounded-2xl shadow-xl overflow-hidden">
                <div className="bg-indigo-600 p-8 text-center">
                    <div className="mx-auto bg-white/20 w-16 h-16 rounded-xl flex items-center justify-center backdrop-blur-sm mb-4">
                        <BookOpen size={32} className="text-white" />
                    </div>
                    <h2 className="text-2xl font-bold text-white">Teacher Portal</h2>
                    <p className="text-indigo-100 mt-2">Sign in to access your dashboard</p>
                </div>

                <div className="p-8">
                    {error && (
                        <div className="bg-red-50 text-red-600 p-3 rounded-lg mb-6 flex items-center gap-2 text-sm">
                            <AlertCircle size={16} />
                            {error}
                        </div>
                    )}

                    <form onSubmit={handleSubmit} className="space-y-6">
                        <Input
                            label="Email Address"
                            icon={Mail}
                            type="email"
                            placeholder="Enter your email"
                            value={formData.username} // Backend expects 'username' key even for email
                            onChange={(e) => setFormData(prev => ({ ...prev, username: e.target.value }))}
                            required
                        />

                        <Input
                            label="Password"
                            icon={Lock}
                            type="password"
                            placeholder="••••••••"
                            value={formData.password}
                            onChange={(e) => setFormData(prev => ({ ...prev, password: e.target.value }))}
                            required
                        />

                        <Button
                            type="submit"
                            className="w-full bg-indigo-600 hover:bg-indigo-700"
                            isLoading={loading}
                        >
                            <LogIn size={18} className="mr-2" /> Sign In
                        </Button>
                    </form>

                    <div className="mt-6 text-center">
                        <a href="/login" className="text-sm text-slate-500 hover:text-indigo-600 transition-colors">
                            Admin/Student Login
                        </a>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default TeacherLogin;
