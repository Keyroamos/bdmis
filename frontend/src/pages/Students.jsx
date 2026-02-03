import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import {
    Plus, Search, Filter, MoreVertical, Edit, Trash,
    ChevronLeft, ChevronRight, UserPlus, Download,
    LayoutGrid, List, GraduationCap, Users, Wallet
} from 'lucide-react';
import Button from '../components/ui/Button';
import axios from 'axios';
import { motion, AnimatePresence } from 'framer-motion';

const Badge = ({ children, variant = 'gray', className = '' }) => {
    const variants = {
        gray: 'bg-slate-100 text-slate-700 dark:bg-slate-800 dark:text-slate-300',
        green: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400',
        red: 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400',
        blue: 'bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-400',
        yellow: 'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400',
        purple: 'bg-violet-100 text-violet-700 dark:bg-violet-900/30 dark:text-violet-400',
    };

    return (
        <span className={`px-2.5 py-1 rounded-full text-xs font-semibold ${variants[variant]} ${className}`}>
            {children}
        </span>
    );
};

const StudentCard = ({ student, onClick }) => (
    <motion.div
        layout
        initial={{ opacity: 0, scale: 0.9 }}
        animate={{ opacity: 1, scale: 1 }}
        exit={{ opacity: 0, scale: 0.9 }}
        whileHover={{ y: -5 }}
        onClick={onClick}
        className="group relative bg-white dark:bg-slate-900 rounded-2xl p-4 md:p-6 shadow-sm border border-slate-100 dark:border-slate-800 hover:shadow-xl hover:border-primary-200 dark:hover:border-primary-800 transition-all duration-300 cursor-pointer overflow-hidden"
    >
        {/* Background Accent */}
        <div className="absolute top-0 right-0 w-24 h-24 md:w-32 md:h-32 bg-primary-50 dark:bg-primary-900/10 rounded-full blur-3xl -mr-12 -mt-12 md:-mr-16 md:-mt-16 transition-opacity group-hover:opacity-75"></div>

        <div className="relative z-10 flex flex-col items-center">
            {/* Avatar & Status */}
            <div className="relative mb-3 md:mb-4">
                <div className="h-16 w-16 md:h-24 md:w-24 rounded-xl md:rounded-2xl bg-gradient-to-br from-primary-100 to-primary-50 dark:from-primary-900/40 dark:to-slate-800 text-primary-600 dark:text-primary-400 flex items-center justify-center text-xl md:text-3xl font-bold shadow-inner overflow-hidden">
                    {student.photo ? (
                        <img src={student.photo} alt={student.full_name} className="w-full h-full object-cover" />
                    ) : (
                        student.full_name.charAt(0)
                    )}
                </div>
                <div className={`absolute -bottom-1 -right-1 md:-bottom-2 md:-right-2 p-1 md:p-1.5 rounded-full bg-white dark:bg-slate-900 border-2 border-white dark:border-slate-900 shadow-sm ${student.balance > 0 ? 'text-red-500' : 'text-green-500'
                    }`}>
                    {student.balance > 0 ? <Wallet size={12} className="md:w-[14px] md:h-[14px]" fill="currentColor" /> : <GraduationCap size={12} className="md:w-[14px] md:h-[14px]" fill="currentColor" />}
                </div>
            </div>

            {/* Info */}
            <h3 className="text-sm md:text-lg font-bold text-slate-900 dark:text-white text-center mb-1 group-hover:text-primary-600 dark:group-hover:text-primary-400 transition-colors line-clamp-1">
                {student.full_name}
            </h3>
            <p className="text-[10px] md:text-xs font-mono text-slate-500 dark:text-slate-400 mb-3 md:mb-4 bg-slate-100 dark:bg-slate-800 px-1.5 py-0.5 md:px-2 md:py-1 rounded">
                #{student.admission_number}
            </p>

            {/* Stats Grid - Hidden on smallest mobile tiles for better fit, show on md */}
            <div className="hidden md:grid grid-cols-2 gap-3 w-full mb-4">
                <div className="bg-slate-50 dark:bg-slate-800/50 p-2.5 rounded-xl text-center">
                    <p className="text-xs text-slate-500 dark:text-slate-400 mb-0.5">Grade</p>
                    <p className="font-semibold text-slate-700 dark:text-slate-200">{student.grade}</p>
                </div>
                <div className="bg-slate-50 dark:bg-slate-800/50 p-2.5 rounded-xl text-center">
                    <p className="text-xs text-slate-500 dark:text-slate-400 mb-0.5">Gender</p>
                    <p className="font-semibold text-slate-700 dark:text-slate-200">{student.gender === 'M' ? 'M' : 'F'}</p>
                </div>
            </div>

            {/* Simple Stats for Mobile */}
            <div className="flex md:hidden items-center justify-center gap-2 mb-3 text-[10px] font-bold text-slate-500">
                <span className="bg-slate-100 dark:bg-slate-800 px-2 py-0.5 rounded">G: {student.grade}</span>
                <span className="bg-slate-100 dark:bg-slate-800 px-2 py-0.5 rounded">{student.gender === 'M' ? 'Male' : 'Female'}</span>
            </div>

            {/* Balance Badge */}
            <div className={`w-full py-1.5 md:py-2 px-2 md:px-3 rounded-lg md:rounded-xl flex items-center justify-between text-[10px] md:text-xs font-medium ${student.balance > 0
                ? 'bg-red-50 text-red-700 dark:bg-red-900/20 dark:text-red-300'
                : 'bg-green-50 text-green-700 dark:bg-green-900/20 dark:text-green-300'
                }`}>
                <span className="hidden xs:inline">Balance</span>
                <span className="font-bold">
                    {student.balance > 0 ? `-$${student.balance.toLocaleString()}` : 'Paid'}
                </span>
            </div>
        </div>
    </motion.div>
);

const Students = () => {
    const navigate = useNavigate();
    const [viewMode, setViewMode] = useState('grid'); // 'list' or 'grid'
    const [students, setStudents] = useState([]);
    const [loading, setLoading] = useState(true);
    const [filters, setFilters] = useState({
        search: '',
        grade: '',
        status: ''
    });
    const [pagination, setPagination] = useState({
        page: 1,
        total: 0,
        pages: 1
    });

    const [stats, setStats] = useState({ fully_paid: '-' });

    const fetchStudents = async () => {
        if (students.length === 0) setLoading(true);
        try {
            const response = await axios.get('/api/students/', {
                params: {
                    ...filters,
                    page: pagination.page
                }
            });
            setStudents(response.data.students);
            if (response.data.stats) {
                setStats(response.data.stats);
            }
            setPagination(prev => ({
                ...prev,
                total: response.data.total,
                pages: response.data.pages,
                page: response.data.current_page
            }));
        } catch (error) {
            console.error('Error fetching students:', error);
        } finally {
            setLoading(false);
        }
    };

    const handleDelete = async (e, id) => {
        e.stopPropagation();
        if (window.confirm('Are you sure you want to delete this student? This action cannot be undone.')) {
            try {
                await axios.delete(`/api/students/${id}/`);
                setStudents(prev => prev.filter(student => student.id !== id));
                setPagination(prev => ({ ...prev, total: prev.total - 1 }));
            } catch (error) {
                console.error('Error deleting student:', error);
                alert('Failed to delete student. Please try again.');
            }
        }
    };

    const [grades, setGrades] = useState([]);

    useEffect(() => {
        const fetchGrades = async () => {
            try {
                const response = await axios.get('/api/grades/');
                setGrades(response.data.grades);
            } catch (error) {
                console.error('Error fetching grades:', error);
            }
        };
        fetchGrades();
    }, []);

    // ... (keep existing useEffect for fetching students)

    useEffect(() => {
        const timer = setTimeout(() => {
            fetchStudents();
        }, 300);
        return () => clearTimeout(timer);
    }, [filters, pagination.page]);


    const containerVariants = {
        hidden: { opacity: 0 },
        show: {
            opacity: 1,
            transition: {
                staggerChildren: 0.1
            }
        }
    };

    return (
        <div className="p-6 max-w-7xl mx-auto space-y-6">
            {/* Header Area */}
            <div className="flex justify-center md:justify-end">
                <div className="flex items-center gap-3 w-full md:w-auto">
                    <Button onClick={() => navigate('/students/create')} className="w-full md:w-auto shadow-lg shadow-primary-500/20">
                        <UserPlus size={18} className="mr-2" />
                        New Admission
                    </Button>
                </div>
            </div>

            {/* Quick Stats Row */}
            <div className="grid grid-cols-2 md:grid-cols-3 gap-4">
                <div className="col-span-2 md:col-span-1 bg-gradient-to-br from-blue-500 to-blue-600 rounded-2xl p-6 text-white shadow-lg shadow-blue-500/20 relative overflow-hidden flex flex-col items-center text-center md:items-start md:text-left">
                    <Users className="absolute right-4 top-4 text-white/10 hidden md:block" size={64} />
                    <Users className="text-white/20 mb-2 md:hidden" size={40} />
                    <p className="text-blue-100 font-medium mb-1">Total Students</p>
                    <div className="flex items-baseline gap-2">
                        <h2 className="text-4xl font-bold">{pagination.total}</h2>
                        <span className="text-sm bg-white/20 px-2 py-0.5 rounded-full">Active</span>
                    </div>
                </div>
                <div className="bg-white dark:bg-slate-900 rounded-2xl p-6 border border-slate-100 dark:border-slate-800 shadow-sm relative group flex flex-col items-center text-center md:items-start md:text-left">
                    <div className="p-2 bg-green-50 dark:bg-green-900/20 rounded-lg inline-block text-green-600 dark:text-green-400 mb-3 group-hover:scale-110 transition-transform">
                        <Wallet size={24} />
                    </div>
                    <div>
                        <p className="text-slate-500 dark:text-slate-400 font-medium">Fully Paid</p>
                        <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
                            {stats.fully_paid}
                            <span className="text-sm font-normal text-slate-400 ml-2">students</span>
                        </h2>
                    </div>
                </div>
                <div className="bg-white dark:bg-slate-900 rounded-2xl p-6 border border-slate-100 dark:border-slate-800 shadow-sm relative group flex flex-col items-center text-center md:items-start md:text-left">
                    <div className="p-2 bg-purple-50 dark:bg-purple-900/20 rounded-lg inline-block text-purple-600 dark:text-purple-400 mb-3 group-hover:scale-110 transition-transform">
                        <GraduationCap size={24} />
                    </div>
                    <div>
                        <p className="text-slate-500 dark:text-slate-400 font-medium">Average Grade</p>
                        <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
                            Grade 2
                            <span className="text-sm font-normal text-slate-400 ml-2">majority</span>
                        </h2>
                    </div>
                </div>
            </div>

            {/* Controls Bar */}
            <div className="bg-white dark:bg-slate-900 p-2 rounded-2xl border border-slate-100 dark:border-slate-800 shadow-sm flex flex-col md:flex-row gap-4 items-center justify-between sticky top-4 z-20">
                {/* Search & Filters */}
                <div className="flex flex-1 gap-2 w-full md:w-auto p-2">
                    <div className="relative flex-1 max-w-md">
                        <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400" size={18} />
                        <input
                            type="text"
                            placeholder="Search students..."
                            className="w-full pl-10 pr-4 py-2 rounded-xl bg-slate-50 dark:bg-slate-800 border-none focus:ring-2 focus:ring-primary-500 transition-all text-sm text-slate-900 dark:text-white placeholder-slate-400"
                            value={filters.search}
                            onChange={(e) => setFilters(prev => ({ ...prev, search: e.target.value }))}
                        />
                    </div>
                    <select
                        className="px-4 py-2 rounded-xl bg-slate-50 dark:bg-slate-800 border-none focus:ring-2 focus:ring-primary-500 text-sm text-slate-700 dark:text-slate-200 cursor-pointer hover:bg-slate-100 dark:hover:bg-slate-700 transition-colors"
                        onChange={(e) => setFilters(prev => ({ ...prev, grade: e.target.value }))}
                    >
                        <option value="">All Grades</option>
                        {(grades || []).map(grade => (
                            <option key={grade.id} value={grade.id}>{grade.name}</option>
                        ))}
                    </select>
                </div>

                {/* View Toggle & Export */}
                <div className="flex items-center gap-2 p-2 border-l border-slate-100 dark:border-slate-800">
                    <div className="bg-slate-100 dark:bg-slate-800 p-1 rounded-lg flex items-center">
                        <button
                            onClick={() => setViewMode('list')}
                            className={`p-2 rounded-md transition-all ${viewMode === 'list'
                                ? 'bg-white dark:bg-slate-700 text-primary-600 dark:text-primary-400 shadow-sm'
                                : 'text-slate-400 hover:text-slate-600 dark:hover:text-slate-300'}`}
                        >
                            <List size={18} />
                        </button>
                        <button
                            onClick={() => setViewMode('grid')}
                            className={`p-2 rounded-md transition-all ${viewMode === 'grid'
                                ? 'bg-white dark:bg-slate-700 text-primary-600 dark:text-primary-400 shadow-sm'
                                : 'text-slate-400 hover:text-slate-600 dark:hover:text-slate-300'}`}
                        >
                            <LayoutGrid size={18} />
                        </button>
                    </div>
                    <Button variant="ghost" size="sm" className="hidden md:flex">
                        <Download size={18} className="mr-2" />
                        Export
                    </Button>
                </div>
            </div>

            {/* Content Area */}
            <div className="min-h-[400px]">
                {(students || []).length > 0 ? (
                    <AnimatePresence mode="wait">
                        {viewMode === 'grid' || window.innerWidth < 768 ? (
                            <motion.div
                                key="grid"
                                variants={containerVariants}
                                initial="hidden"
                                animate="show"
                                className="grid grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4 md:gap-6"
                            >
                                {students.map((student) => (
                                    <StudentCard
                                        key={student.id}
                                        student={student}
                                        onClick={() => navigate(`/students/${student.id}`)}
                                    />
                                ))}
                            </motion.div>
                        ) : (
                            <motion.div
                                key="list"
                                initial={{ opacity: 0, y: 10 }}
                                animate={{ opacity: 1, y: 0 }}
                                exit={{ opacity: 0, y: -10 }}
                                className="bg-white dark:bg-slate-900 rounded-3xl border border-slate-100 dark:border-slate-800 shadow-sm overflow-hidden"
                            >
                                <div className="overflow-x-auto">
                                    <table className="w-full">
                                        <thead className="bg-slate-50/50 dark:bg-slate-800/50">
                                            <tr>
                                                <th className="px-6 py-5 text-left text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Student</th>
                                                <th className="px-6 py-5 text-left text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Grade</th>
                                                <th className="px-6 py-5 text-left text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Branch</th>
                                                <th className="px-6 py-5 text-left text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Gender</th>
                                                <th className="px-6 py-5 text-left text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Financial Status</th>
                                                <th className="px-6 py-5 text-left text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Status</th>
                                                <th className="px-6 py-5 text-right text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody className="divide-y divide-slate-100 dark:divide-slate-800">
                                            {students.map((student) => (
                                                <tr
                                                    key={student.id}
                                                    className="group hover:bg-slate-50 dark:hover:bg-slate-800/50 transition-colors cursor-pointer"
                                                    onClick={() => navigate(`/students/${student.id}`)}
                                                >
                                                    <td className="px-6 py-4">
                                                        <div className="flex items-center gap-4">
                                                            <div className="h-12 w-12 rounded-xl bg-gradient-to-br from-primary-100 to-primary-50 dark:from-primary-900/30 dark:to-slate-800 text-primary-600 dark:text-primary-400 flex items-center justify-center font-bold text-lg shadow-sm overflow-hidden">
                                                                {student.photo ? (
                                                                    <img src={student.photo} alt={student.full_name} className="w-full h-full object-cover" />
                                                                ) : (
                                                                    student.full_name.charAt(0)
                                                                )}
                                                            </div>
                                                            <div>
                                                                <p className="font-bold text-slate-900 dark:text-white">{student.full_name}</p>
                                                                <p className="text-xs font-mono text-slate-500 dark:text-slate-400 bg-slate-100 dark:bg-slate-800 p-0.5 px-1.5 rounded inline-block mt-1">
                                                                    #{student.admission_number}
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td className="px-6 py-4 text-sm font-medium text-slate-600 dark:text-slate-300">
                                                        Grade {student.grade}
                                                    </td>
                                                    <td className="px-6 py-4 text-sm text-slate-600 dark:text-slate-300">
                                                        {student.branch}
                                                    </td>
                                                    <td className="px-6 py-4 text-sm text-slate-600 dark:text-slate-300">
                                                        {student.gender === 'M' ? 'Male' : 'Female'}
                                                    </td>
                                                    <td className="px-6 py-4">
                                                        {student.balance > 0 ? (
                                                            <div className="flex items-center gap-2 text-red-600 dark:text-red-400">
                                                                <div className="w-1.5 h-1.5 rounded-full bg-red-500"></div>
                                                                <span className="font-bold">-${student.balance.toLocaleString()}</span>
                                                            </div>
                                                        ) : (
                                                            <div className="flex items-center gap-2 text-green-600 dark:text-green-400">
                                                                <div className="w-1.5 h-1.5 rounded-full bg-green-500"></div>
                                                                <span className="font-bold">Paid</span>
                                                            </div>
                                                        )}
                                                    </td>
                                                    <td className="px-6 py-4">
                                                        <Badge variant="green">Active</Badge>
                                                    </td>
                                                    <td className="px-6 py-4 text-right">
                                                        <div className="flex items-center justify-end gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                                                            <button className="p-2 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-400 hover:text-primary-600 transition-colors">
                                                                <Edit size={16} />
                                                            </button>
                                                            <button
                                                                onClick={(e) => handleDelete(e, student.id)}
                                                                className="p-2 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg text-slate-400 hover:text-red-600 transition-colors"
                                                            >
                                                                <Trash size={16} />
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            ))}
                                        </tbody>
                                    </table>
                                </div>
                            </motion.div>
                        )}
                    </AnimatePresence>
                ) : (
                    <div className="text-center py-20 bg-white dark:bg-slate-900 rounded-3xl border border-slate-100 dark:border-slate-800 border-dashed">
                        <div className="w-20 h-20 bg-slate-50 dark:bg-slate-800 rounded-full flex items-center justify-center mx-auto mb-4">
                            <Search className="text-slate-300 dark:text-slate-600" size={32} />
                        </div>
                        <h3 className="text-lg font-bold text-slate-900 dark:text-white mb-1">No students found</h3>
                        <p className="text-slate-500 dark:text-slate-400">Try adjusting your filters or add a new student.</p>
                        <Button
                            variant="primary"
                            className="mt-6"
                            onClick={() => navigate('/students/create')}
                        >
                            <UserPlus size={18} className="mr-2" />
                            New Admission
                        </Button>
                    </div>
                )}
            </div>

            {/* Pagination Floating Bar */}
            <div className="fixed bottom-6 left-1/2 -translate-x-1/2 bg-white/90 dark:bg-slate-900/90 backdrop-blur shadow-xl border border-slate-100 dark:border-slate-800 rounded-full py-2 px-6 flex items-center gap-4 z-30 transform hover:scale-105 transition-transform">
                <button
                    disabled={pagination.page <= 1}
                    onClick={() => setPagination(p => ({ ...p, page: p.page - 1 }))}
                    className="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-full text-slate-500 disabled:opacity-50 transition-colors"
                >
                    <ChevronLeft size={20} />
                </button>
                <span className="text-sm font-medium text-slate-700 dark:text-slate-300 min-w-[100px] text-center">
                    Page {pagination.page} of {pagination.pages}
                </span>
                <button
                    disabled={pagination.page >= pagination.pages}
                    onClick={() => setPagination(p => ({ ...p, page: p.page + 1 }))}
                    className="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-full text-slate-500 disabled:opacity-50 transition-colors"
                >
                    <ChevronRight size={20} />
                </button>
            </div>
        </div>
    );
};

export default Students;
