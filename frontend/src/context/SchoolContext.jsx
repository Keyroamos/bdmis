import React, { createContext, useContext, useState, useEffect } from 'react';
import axios from 'axios';

const SchoolContext = createContext();

export const SchoolProvider = ({ children }) => {
    const [config, setConfig] = useState(() => {
        const cached = localStorage.getItem('school_config');
        return cached ? JSON.parse(cached) : {
            school_name: 'EduManage',
            school_code: 'EDU',
            school_email: '',
            school_phone: '',
            school_address: '',
            school_logo: null,
        };
    });
    const [loading, setLoading] = useState(true);

    const fetchConfig = async () => {
        try {
            const response = await axios.get('/api/config/');
            const data = response.data.config || {};
            setConfig(data);
            // Also store in localStorage for quick access on reload
            localStorage.setItem('school_config', JSON.stringify(data));
        } catch (error) {
            console.error('Error fetching school config:', error);
            const cached = localStorage.getItem('school_config');
            if (cached) {
                setConfig(JSON.parse(cached));
            }
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchConfig();
    }, []);

    const updateConfig = (newConfig) => {
        setConfig(prev => {
            const updated = { ...prev, ...newConfig };
            localStorage.setItem('school_config', JSON.stringify(updated));
            return updated;
        });
    };

    return (
        <SchoolContext.Provider value={{ config, fetchConfig, updateConfig, loading }}>
            {children}
        </SchoolContext.Provider>
    );
};

export const useSchool = () => {
    const context = useContext(SchoolContext);
    if (!context) {
        throw new Error('useSchool must be used within a SchoolProvider');
    }
    return context;
};
