import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { Mail, Lock, ArrowRight, BookOpen, AlertCircle } from 'lucide-react';
import Button from '../components/ui/Button';
import Input from '../components/ui/Input';
import { Link, useNavigate } from 'react-router-dom';
import axios from 'axios';
import { useSchool } from '../context/SchoolContext';

const Login = () => {
    const navigate = useNavigate();
    const { config } = useSchool();
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);
    const [formData, setFormData] = useState({
        username: '',
        password: ''
    });

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        setError(null);

        try {
            const response = await axios.post('/api/login/', {
                username: formData.username,
                password: formData.password
            });

            if (response.data.success) {
                // Store user data
                localStorage.setItem('user', JSON.stringify(response.data.user));
                // Redirect
                navigate(response.data.redirect_url || '/dashboard');
            }
        } catch (err) {
            console.error('Login failed', err);
            setError(err.response?.data?.error || 'Login failed. Please check your credentials.');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="min-h-screen w-full flex bg-slate-50 relative overflow-hidden">
            {/* Background decorations for Mobile/Tablet */}
            <div className="lg:hidden absolute top-0 left-0 w-full h-full overflow-hidden pointer-events-none">
                <div className="absolute top-0 left-0 w-full h-64 bg-primary-900 rounded-b-[40px]"></div>
                <div className="absolute -top-24 -right-12 w-64 h-64 bg-primary-500/30 rounded-full blur-3xl"></div>
                <div className="absolute top-20 -left-12 w-48 h-48 bg-primary-300/20 rounded-full blur-3xl"></div>
            </div>

            {/* Left Side - Hero Section (Desktop only) */}
            <div className="hidden lg:flex w-1/2 bg-primary-900 relative overflow-hidden items-center justify-center p-12">
                {/* Abstract Background Shapes */}
                <div className="absolute top-0 left-0 w-full h-full opacity-10">
                    <svg className="w-full h-full" viewBox="0 0 100 100" preserveAspectRatio="none">
                        <path d="M0 0 L100 0 L100 100 L0 100 Z" fill="url(#grid)" />
                        <defs>
                            <pattern id="grid" width="4" height="4" patternUnits="userSpaceOnUse">
                                <path d="M 4 0 L 0 0 0 4" fill="none" stroke="currentColor" strokeWidth="0.5" />
                            </pattern>
                        </defs>
                    </svg>
                </div>
                <div className="absolute -top-24 -left-24 w-96 h-96 bg-primary-500 rounded-full mix-blend-multiply filter blur-3xl opacity-20 animate-blob"></div>
                <div className="absolute -bottom-24 -right-24 w-96 h-96 bg-blue-500 rounded-full mix-blend-multiply filter blur-3xl opacity-20 animate-blob animation-delay-2000"></div>

                <div className="relative z-10 text-white max-w-lg">
                    <motion.div
                        initial={{ opacity: 0, y: 20 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ duration: 0.8 }}
                    >
                        <div className="h-16 w-16 bg-white/10 backdrop-blur-lg rounded-2xl flex items-center justify-center mb-8 border border-white/20 overflow-hidden">
                            {config.school_logo ? (
                                <img src={config.school_logo} alt="School Logo" className="h-full w-full object-cover" />
                            ) : (
                                <BookOpen size={32} className="text-white" />
                            )}
                        </div>
                        <h1 className="text-5xl font-bold mb-6 leading-tight">
                            Manage your school with <span className="text-primary-400">Excellence</span>
                        </h1>
                        <p className="text-lg text-primary-100 mb-8 leading-relaxed">
                            Streamline administration, enhance learning, and communicate effectively. The complete platform for modern education.
                        </p>

                        <div className="space-y-4">
                            <div className="flex items-center space-x-4 bg-white/5 p-4 rounded-xl border border-white/10 backdrop-blur-sm">
                                <div className="h-10 w-10 rounded-full bg-primary-500/20 flex items-center justify-center">
                                    <div className="h-3 w-3 rounded-full bg-primary-400"></div>
                                </div>
                                <div>
                                    <p className="font-medium">Real-time Analytics</p>
                                    <p className="text-sm text-primary-200">Track performance instantly</p>
                                </div>
                            </div>
                        </div>
                    </motion.div>
                </div>
            </div>

            {/* Right Side - Login Form */}
            <div className="w-full lg:w-1/2 flex flex-col items-center justify-center p-6 sm:p-12 relative z-10">
                <motion.div
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.5, delay: 0.2 }}
                    className="w-full max-w-md bg-white rounded-3xl shadow-xl lg:shadow-none lg:bg-transparent p-8 lg:p-0"
                >
                    {/* Mobile Logo centered */}
                    <div className="lg:hidden flex justify-center -mt-20 mb-8">
                        <div className="h-20 w-20 bg-white rounded-2xl flex items-center justify-center shadow-lg border-4 border-slate-50 text-primary-600 overflow-hidden">
                            {config.school_logo ? (
                                <img src={config.school_logo} alt="School Logo" className="h-full w-full object-cover" />
                            ) : (
                                <BookOpen size={40} />
                            )}
                        </div>
                    </div>

                    <div className="text-center lg:text-left">
                        <h2 className="text-2xl lg:text-3xl font-bold tracking-tight text-slate-900">
                            To Get Started
                        </h2>
                        <p className="mt-2 text-slate-500 text-sm lg:text-base">
                            Sign in to manage your institution
                        </p>
                    </div>

                    <form onSubmit={handleSubmit} className="mt-8 space-y-6">
                        {error && (
                            <div className="flex items-center gap-2 p-4 text-sm text-red-600 bg-red-50 rounded-xl border border-red-100 animate-in fade-in slide-in-from-top-2">
                                <AlertCircle size={16} className="shrink-0" />
                                <p>{error}</p>
                            </div>
                        )}

                        <div className="space-y-5">
                            <Input
                                label="Username or Email"
                                type="text"
                                placeholder="name@school.com or username"
                                icon={Mail}
                                value={formData.username}
                                onChange={(e) => setFormData({ ...formData, username: e.target.value })}
                                required
                                className="bg-slate-50 border-slate-200"
                            />

                            <div>
                                <Input
                                    label="Password"
                                    type="password"
                                    placeholder="••••••••"
                                    icon={Lock}
                                    value={formData.password}
                                    onChange={(e) => setFormData({ ...formData, password: e.target.value })}
                                    required
                                    className="bg-slate-50 border-slate-200"
                                />
                                <div className="flex items-center justify-end mt-2">
                                    <a href="#" className="text-xs lg:text-sm font-medium text-primary-600 hover:text-primary-500">
                                        Forgot password?
                                    </a>
                                </div>
                            </div>
                        </div>

                        <Button
                            type="submit"
                            className="w-full shadow-lg shadow-primary-500/30 hover:shadow-primary-500/50 transition-shadow"
                            size="lg"
                            isLoading={loading}
                        >
                            Log In
                            <ArrowRight className="ml-2 h-5 w-5" />
                        </Button>
                    </form>

                    <div className="mt-8 text-center text-sm text-slate-500 lg:hidden">
                        <p>Protected by SchoolGuard™ Security</p>
                    </div>
                </motion.div>

                {/* Footer for Desktop */}
                <p className="hidden lg:block absolute bottom-8 text-center text-sm text-slate-400">
                    © {new Date().getFullYear()} {config.school_name}. All rights reserved.
                </p>
            </div>
        </div >
    );
};

export default Login;
