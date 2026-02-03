import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { Save, AlertCircle, CheckCircle, Search, DollarSign } from 'lucide-react';
import Button from '../../components/ui/Button';
import Input from '../../components/ui/Input';

const FeeStructure = () => {
    const [grades, setGrades] = useState([]);
    const [loading, setLoading] = useState(true);
    const [saving, setSaving] = useState(false);
    const [searchTerm, setSearchTerm] = useState('');
    const [message, setMessage] = useState(null);

    useEffect(() => {
        fetchGrades();
    }, []);

    const fetchGrades = async () => {
        try {
            const response = await axios.get('/api/grades/');
            setGrades(response.data.grades);
        } catch (error) {
            console.error(error);
        } finally {
            setLoading(false);
        }
    };

    const handleFeeChange = (gradeId, term, value) => {
        setGrades(grades.map(g => {
            if (g.id === gradeId) {
                return { ...g, [term]: value };
            }
            return g;
        }));
    };

    const handleSave = async (grade) => {
        setSaving(true);
        setMessage(null);
        try {
            await axios.post(`/api/grades/${grade.id}/fees/`, {
                term1_fees: grade.term1_fees,
                term2_fees: grade.term2_fees,
                term3_fees: grade.term3_fees
            });
            setMessage({ type: 'success', text: `Fees updated for ${grade.name} and all students.` });
        } catch (error) {
            console.error(error);
            setMessage({ type: 'error', text: 'Failed to update fees.' });
        } finally {
            setSaving(false);
            // Clear message after 3 seconds
            setTimeout(() => setMessage(null), 3000);
        }
    };

    const filteredGrades = grades.filter(g =>
        g.name.toLowerCase().includes(searchTerm.toLowerCase())
    );

    if (loading) {
        return <div className="p-8 text-center">Loading classes...</div>;
    }

    return (
        <div className="space-y-6 animate-fade-in-up">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                <div>
                    <h2 className="text-xl font-bold text-slate-900 dark:text-white">Class Fee Structure</h2>
                    <p className="text-sm text-slate-500 dark:text-slate-400">Manage school fees for each class and term</p>
                </div>
                <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400" size={18} />
                    <input
                        type="text"
                        placeholder="Search class..."
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                        className="pl-10 pr-4 py-2 w-full sm:w-64 rounded-lg border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-sm outline-none focus:ring-2 focus:ring-indigo-500"
                    />
                </div>
            </div>

            {message && (
                <div className={`p-4 rounded-lg flex items-center gap-2 ${message.type === 'success' ? 'bg-emerald-50 text-emerald-700 border border-emerald-100' : 'bg-red-50 text-red-700 border border-red-100'
                    }`}>
                    {message.type === 'success' ? <CheckCircle size={18} /> : <AlertCircle size={18} />}
                    {message.text}
                </div>
            )}

            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {filteredGrades.map(grade => (
                    <div key={grade.id} className="bg-white dark:bg-slate-900 rounded-xl shadow-sm border border-slate-100 dark:border-slate-800 p-6 hover:shadow-md transition-shadow">
                        <div className="flex justify-between items-start mb-4">
                            <h3 className="text-lg font-bold text-slate-900 dark:text-white">{grade.name}</h3>
                            <div className="p-2 bg-indigo-50 dark:bg-indigo-900/20 text-indigo-600 rounded-lg">
                                <DollarSign size={20} />
                            </div>
                        </div>

                        <div className="space-y-4">
                            <div>
                                <label className="block text-xs font-semibold text-slate-500 uppercase mb-1">Term 1 Fee (KES)</label>
                                <Input
                                    type="number"
                                    value={grade.term1_fees}
                                    onChange={(e) => handleFeeChange(grade.id, 'term1_fees', e.target.value)}
                                    className="w-full font-mono font-medium"
                                    placeholder="0.00"
                                />
                            </div>
                            <div>
                                <label className="block text-xs font-semibold text-slate-500 uppercase mb-1">Term 2 Fee (KES)</label>
                                <Input
                                    type="number"
                                    value={grade.term2_fees}
                                    onChange={(e) => handleFeeChange(grade.id, 'term2_fees', e.target.value)}
                                    className="w-full font-mono font-medium"
                                    placeholder="0.00"
                                />
                            </div>
                            <div>
                                <label className="block text-xs font-semibold text-slate-500 uppercase mb-1">Term 3 Fee (KES)</label>
                                <Input
                                    type="number"
                                    value={grade.term3_fees}
                                    onChange={(e) => handleFeeChange(grade.id, 'term3_fees', e.target.value)}
                                    className="w-full font-mono font-medium"
                                    placeholder="0.00"
                                />
                            </div>

                            <div className="pt-4 border-t border-slate-100 dark:border-slate-800">
                                <Button
                                    onClick={() => handleSave(grade)}
                                    // isLoading={saving} // This would show loading on all buttons, we just want it to be responsive
                                    className="w-full"
                                >
                                    <Save size={18} className="mr-2" />
                                    Update Fees
                                </Button>
                                <p className="text-xs text-slate-400 text-center mt-2">
                                    Updates all students in this class
                                </p>
                            </div>
                        </div>
                    </div>
                ))}
            </div>

            {filteredGrades.length === 0 && !loading && (
                <div className="text-center py-12 text-slate-500">
                    No classes found matching your search.
                </div>
            )}
        </div>
    );
};

export default FeeStructure;
