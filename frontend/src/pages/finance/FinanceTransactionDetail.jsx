import React, { useState, useEffect, useRef } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import axios from 'axios';
import {
    ArrowLeft, Printer, Download, Share2,
    CheckCircle, FileText, Building2, GraduationCap, MapPin, Phone, Mail, QrCode
} from 'lucide-react';
import Button from '../../components/ui/Button';
import { useSchool } from '../../context/SchoolContext';
import { useReactToPrint } from 'react-to-print';

const FinanceTransactionDetail = () => {
    const { id } = useParams();
    const navigate = useNavigate();
    const { config } = useSchool();
    const [data, setData] = useState(null);
    const [loading, setLoading] = useState(true);
    const componentRef = useRef();

    useEffect(() => {
        const fetchData = async () => {
            try {
                const res = await axios.get(`/api/finance/transactions/${id}/`);
                setData(res.data);
            } catch (error) {
                console.error(error);
            } finally {
                setLoading(false);
            }
        };
        fetchData();
    }, [id]);

    const handlePrint = useReactToPrint({
        contentRef: componentRef,
        documentTitle: `Receipt_${data?.transaction?.id || 'doc'}`,
    });

    const handleDownloadPDF = () => {
        // Redirect to backend PDF generator
        window.open(`/api/finance/transactions/${id}/pdf/`, '_blank');
    };

    if (loading) return (
        <div className="min-h-screen flex items-center justify-center">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-indigo-600"></div>
        </div>
    );

    if (!data) return <div className="p-12 text-center text-slate-500">Transaction not found.</div>;

    const { transaction, student } = data;

    return (
        <div className="p-4 md:p-8 max-w-5xl mx-auto space-y-8 bg-slate-50 dark:bg-slate-950/20 min-h-screen">
            {/* Action Bar */}
            <div className="flex flex-col sm:flex-row items-center justify-between gap-4 bg-white dark:bg-slate-900 p-4 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm print:hidden">
                <button
                    onClick={() => navigate(-1)}
                    className="flex items-center gap-2 text-slate-500 hover:text-slate-900 transition-colors font-medium"
                >
                    <ArrowLeft size={18} /> Back to Ledger
                </button>
                <div className="flex items-center gap-3 w-full sm:w-auto">
                    <Button variant="outline" className="flex-1 sm:flex-initial gap-2 border-slate-200 hover:bg-slate-50" onClick={handlePrint}>
                        <Printer size={18} /> Print Receipt
                    </Button>
                    <Button className="flex-1 sm:flex-initial gap-2 bg-indigo-600 hover:bg-indigo-700 text-white shadow-lg shadow-indigo-600/20" onClick={handleDownloadPDF}>
                        <Download size={18} /> Download official PDF
                    </Button>
                </div>
            </div>

            {/* Receipt Container */}
            <div className="flex justify-center items-start">
                <div
                    ref={componentRef}
                    className="w-full max-w-[210mm] bg-white text-slate-950 shadow-2xl overflow-hidden relative"
                    style={{
                        fontFamily: "'Inter', system-ui, sans-serif",
                        minHeight: '297mm', // A4 height
                        padding: '20mm'
                    }}
                >
                    {/* Watermark Logo (Mock) */}
                    <div className="absolute inset-0 flex items-center justify-center opacity-[0.03] pointer-events-none select-none overflow-hidden">
                        <GraduationCap size={600} strokeWidth={1} />
                    </div>

                    {/* Official Border Top */}
                    <div className="absolute top-0 left-0 w-full h-1.5 bg-indigo-600"></div>

                    {/* Header Section */}
                    <div className="flex justify-between items-start border-b-2 border-slate-100 pb-10 mb-10">
                        <div className="space-y-4">
                            <div className="flex items-center gap-3">
                                <div className="h-16 w-16 bg-indigo-600 rounded-2xl flex items-center justify-center text-white shadow-xl shadow-indigo-600/20 overflow-hidden">
                                    {config.school_logo ? (
                                        <img src={config.school_logo} alt="School Logo" className="h-full w-full object-cover" />
                                    ) : (
                                        <Building2 size={36} />
                                    )}
                                </div>
                                <div>
                                    <h1 className="text-3xl font-black uppercase tracking-tight text-indigo-950 leading-none">
                                        {config.school_name}
                                    </h1>
                                    <p className="text-indigo-600 font-bold tracking-[0.2em] text-xs uppercase mt-1">Official Financial Document</p>
                                </div>
                            </div>
                            <div className="text-sm text-slate-500 space-y-1 pl-1">
                                <p className="flex items-center gap-2"><MapPin size={14} className="text-slate-400" /> {config.school_address}</p>
                                <p className="flex items-center gap-2"><Phone size={14} className="text-slate-400" /> {config.school_phone}</p>
                                <p className="flex items-center gap-2"><Mail size={14} className="text-slate-400" /> {config.school_email}</p>
                            </div>
                        </div>

                        <div className="text-right space-y-2">
                            <div className="bg-indigo-50 text-indigo-700 font-black text-4xl px-6 py-4 rounded-3xl inline-block shadow-inner ring-1 ring-indigo-100">
                                RECEIPT
                            </div>
                            <div className="space-y-1">
                                <p className="text-xs font-bold text-slate-400 uppercase tracking-widest">Receipt Number</p>
                                <p className="text-xl font-mono font-bold text-slate-900 tracking-tighter">#{transaction.id.toString().padStart(8, '0')}</p>
                            </div>
                            <div className="inline-flex items-center gap-2 bg-emerald-50 text-emerald-700 px-4 py-1.5 rounded-full text-xs font-black uppercase ring-1 ring-emerald-100 italic">
                                <CheckCircle size={14} strokeWidth={3} /> Payment Captured
                            </div>
                        </div>
                    </div>

                    {/* Information Grid */}
                    <div className="grid grid-cols-2 gap-12 mb-12">
                        {/* Student Details */}
                        <div className="bg-slate-50/50 p-6 rounded-3xl ring-1 ring-slate-100">
                            <h3 className="text-xs font-black text-slate-400 uppercase tracking-widest mb-4 border-b border-slate-200 pb-2">Student Information</h3>
                            <div className="space-y-3">
                                <div className="flex justify-between items-baseline">
                                    <span className="text-sm text-slate-500">Full Name</span>
                                    <span className="text-md font-bold text-slate-900">{student.name}</span>
                                </div>
                                <div className="flex justify-between items-baseline">
                                    <span className="text-sm text-slate-500">Admission No.</span>
                                    <span className="text-md font-mono font-bold text-slate-900 underline decoration-indigo-200">{student.admission_number}</span>
                                </div>
                                <div className="flex justify-between items-baseline">
                                    <span className="text-sm text-slate-500">Current Grade</span>
                                    <span className="text-md font-bold text-slate-700 bg-white px-3 py-0.5 rounded-lg border border-slate-100">{student.grade}</span>
                                </div>
                                {student.balance > 0 && (
                                    <div className="flex justify-between items-baseline pt-2 border-t border-slate-200 border-dashed mt-2">
                                        <span className="text-sm font-bold text-red-500">Balance C/F</span>
                                        <span className="text-md font-bold text-red-600">KES {student.balance.toLocaleString()}</span>
                                    </div>
                                )}
                            </div>
                        </div>

                        {/* Payment Details */}
                        <div className="bg-slate-50/50 p-6 rounded-3xl ring-1 ring-slate-100">
                            <h3 className="text-xs font-black text-slate-400 uppercase tracking-widest mb-4 border-b border-slate-200 pb-2">Transaction Details</h3>
                            <div className="space-y-3">
                                <div className="flex justify-between items-baseline">
                                    <span className="text-sm text-slate-500">Date & Time</span>
                                    <span className="text-md font-bold text-slate-700">{transaction.date}</span>
                                </div>
                                <div className="flex justify-between items-baseline">
                                    <span className="text-sm text-slate-500">Method</span>
                                    <span className="text-md font-bold text-slate-900">{transaction.method}</span>
                                </div>
                                <div className="flex justify-between items-baseline">
                                    <span className="text-sm text-slate-500">Ref Code</span>
                                    <span className="text-md font-mono font-bold text-indigo-700 break-all">{transaction.reference || 'N/A'}</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    {/* Financial Summary Table */}
                    <div className="mb-12">
                        <table className="w-full">
                            <thead>
                                <tr className="text-left">
                                    <th className="py-4 px-6 bg-slate-900 text-white font-bold uppercase text-[10px] tracking-widest rounded-tl-2xl">Description of Service/Fee</th>
                                    <th className="py-4 px-6 bg-slate-900 text-white font-bold uppercase text-[10px] tracking-widest text-right">Unit Price</th>
                                    <th className="py-4 px-6 bg-slate-900 text-white font-bold uppercase text-[10px] tracking-widest text-right rounded-tr-2xl">Amount Paid (KES)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr className="border-b-2 border-slate-100">
                                    <td className="py-8 px-6">
                                        <p className="font-bold text-lg text-slate-900">{transaction.description}</p>
                                        <div className="flex items-center gap-2 mt-1">
                                            <span className="text-[10px] font-black text-white bg-indigo-500 px-2 py-0.5 rounded uppercase tracking-tighter">Category</span>
                                            <span className="text-xs font-semibold text-slate-400 capitalize">{transaction.type?.toLowerCase().replace('_', ' ')}</span>
                                        </div>
                                    </td>
                                    <td className="py-8 px-6 text-right font-mono text-slate-500">
                                        {transaction.amount.toLocaleString()}
                                    </td>
                                    <td className="py-8 px-6 text-right font-mono text-xl font-black text-slate-900">
                                        {transaction.amount.toLocaleString()}.00
                                    </td>
                                </tr>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colSpan="2" className="py-8 text-right pr-6">
                                        <p className="text-xl font-bold text-slate-400 uppercase tracking-widest">Total Net Payment</p>
                                    </td>
                                    <td className={`py-8 px-6 text-right bg-indigo-50 ${student.balance > 0 ? '' : 'rounded-b-2xl'}`}>
                                        <p className="text-3xl font-black text-indigo-700">
                                            <span className="text-lg font-bold mr-1">KES</span>
                                            {transaction.amount.toLocaleString()}.00
                                        </p>
                                    </td>
                                </tr>
                                {student.balance > 0 && (
                                    <tr>
                                        <td colSpan="2" className="py-6 text-right pr-6 border-t border-slate-100">
                                            <p className="text-sm font-bold text-red-400 uppercase tracking-widest">Outstanding Balance</p>
                                        </td>
                                        <td className="py-6 px-6 text-right bg-red-50 rounded-b-2xl border-t border-white">
                                            <p className="text-xl font-bold text-red-600">
                                                <span className="text-sm mr-1">KES</span>
                                                {student.balance.toLocaleString()}
                                            </p>
                                        </td>
                                    </tr>
                                )}
                            </tfoot>
                        </table>
                    </div>

                    {/* Footer Auth Section */}
                    <div className="grid grid-cols-2 gap-20 pt-10 border-t-2 border-slate-100 mt-auto">
                        <div className="space-y-6">
                            <div className="p-4 bg-slate-50 rounded-2xl border border-slate-100 inline-block">
                                <div className="h-24 w-24 bg-white flex items-center justify-center border-2 border-slate-200">
                                    {/* Mock QR Code */}
                                    <QrCode size={80} className="text-slate-300" />
                                </div>
                                <p className="text-[8px] text-slate-400 mt-2 font-mono uppercase text-center">Scan to Verify Transaction</p>
                            </div>
                            <div className="space-y-1">
                                <p className="text-[10px] font-black text-slate-400 uppercase tracking-widest leading-relaxed">
                                    Disclaimers & Conditions:<br />
                                    1. This is a computer-generated official receipt.<br />
                                    2. Fees paid are non-refundable and non-transferable.<br />
                                    3. Please retain this receipt for future academic queries.
                                </p>
                            </div>
                        </div>

                        <div className="space-y-12">
                            <div className="text-right">
                                <p className="text-xs text-slate-400 font-bold uppercase tracking-widest mb-1">Served By:</p>
                                <p className="text-lg font-bold text-slate-800 italic underline decoration-slate-200">{transaction.recorded_by}</p>
                                <p className="text-[10px] text-slate-400 font-mono mt-1">Authorized Finance Officer</p>
                            </div>

                            <div className="space-y-4">
                                <div className="border-b-2 border-slate-200 pb-1 flex justify-between items-baseline">
                                    <span className="text-[10px] font-black text-slate-300 uppercase">OFFICIAL SEAL / STAMP</span>
                                    <div className="h-20 w-20 rounded-full border-4 border-dashed border-slate-100"></div>
                                </div>
                                <div className="flex justify-between items-center text-[10px] text-slate-400 font-bold uppercase tracking-tighter">
                                    <span>Date of Issue: {new Date().toLocaleDateString()}</span>
                                    <span>Security Code: {Math.random().toString(36).substring(2, 10).toUpperCase()}</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    {/* Footer Copyright */}
                    <div className="absolute bottom-6 left-0 w-full text-center">
                        <p className="text-[9px] text-slate-300 font-bold uppercase tracking-[0.4em]">
                            {config.school_name} - {new Date().getFullYear()} - OFFICIAL DOCUMENT
                        </p>
                    </div>
                </div>
            </div>

            {/* Print Styles */}
            <style>{`
                @media print {
                    @page {
                        size: A4;
                        margin: 0;
                    }
                    body {
                        background: white !important;
                        print-color-adjust: exact;
                        -webkit-print-color-adjust: exact;
                    }
                }
            `}</style>
        </div>
    );
};

export default FinanceTransactionDetail;
