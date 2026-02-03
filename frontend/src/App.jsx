import React, { useEffect } from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate, Outlet } from 'react-router-dom';
import Login from './pages/Login';
import DashboardLayout from './components/layout/DashboardLayout';

const ProtectedRoute = () => {
  const user = JSON.parse(localStorage.getItem('user') || 'null');
  if (!user) {
    return <Navigate to="/login" replace />;
  }
  return <Outlet />;
};

const SuperuserRoute = () => {
  const user = JSON.parse(localStorage.getItem('user') || 'null');
  if (!user) {
    return <Navigate to="/login" replace />;
  }
  if (!user.is_superuser) {
    // Redirect non-superusers based on their role
    if (user.role === 'teacher' && user.teacher_id) {
      return <Navigate to={`/teacher/${user.teacher_id}`} replace />;
    }
    if (user.role === 'driver') {
      return <Navigate to="/driver-portal/dashboard" replace />;
    }
    // Default: redirect to login with error
    localStorage.removeItem('user');
    return <Navigate to="/login" replace />;
  }
  return <Outlet />;
};

import Dashboard from './pages/Dashboard';
import Students from './pages/Students';
import StudentCreate from './pages/StudentCreate';
import StudentEdit from './pages/StudentEdit';
import StudentDetail from './pages/StudentDetail';
import Teachers from './pages/Teachers';
import TeacherCreate from './pages/TeacherCreate';
import TeacherDetail from './pages/TeacherDetail';
import TeacherScheduleManage from './pages/TeacherScheduleManage';
import Finance from './pages/Finance';
import Transactions from './pages/Transactions';
import PaymentRecord from './pages/PaymentRecord';
import Schedule from './pages/Schedule';
import Settings from './pages/Settings';
import Academics from './pages/Academics';
import StudentAcademicReport from './pages/StudentAcademicReport';
import HRStaff from './pages/HRStaff';
import StaffDetail from './pages/StaffDetail';
import StaffCreate from './pages/StaffCreate';
import StaffEdit from './pages/StaffEdit';
import HRApprovals from './pages/HRApprovals';
import Supervisors from './pages/Supervisors';
import AcademicManagement from './pages/AcademicManagement';

// New Finance Portal Pages
import FinanceLayout from './components/layout/FinanceLayout';
import FinancePortalDashboard from './pages/finance/FinanceDashboard';
import FinancePortalAccounts from './pages/finance/FinanceStudentList';
import FinancePortalStudentDetail from './pages/finance/FinanceStudentDetail';
import FinancePortalTransactionDetail from './pages/finance/FinanceTransactionDetail';
import FinancePortalTransactions from './pages/finance/FinanceTransactionList';
import FinancePortalReports from './pages/finance/FinanceReports';
import FoodLayout from './components/layout/FoodLayout';
import FoodDashboard from './pages/food/FoodDashboard';
import FoodStudentList from './pages/food/FoodStudentList';
import FoodStudentDetail from './pages/food/FoodStudentDetail';
import FoodMealOptions from './pages/food/FoodMealOptions';
import FoodServingList from './pages/food/FoodServingList';

// Transport Portal Pages
import TransportLayout from './components/layout/TransportLayout';
import TransportDashboard from './pages/transport/TransportDashboard';
import TransportStudentList from './pages/transport/TransportStudentList';
import TransportStudentDetail from './pages/transport/TransportStudentDetail';
import TransportRoutes from './pages/transport/TransportRoutes';
import TransportRouteDetail from './pages/transport/TransportRouteDetail';
import TransportVehicles from './pages/transport/TransportVehicles';
import TransportVehicleDetail from './pages/transport/TransportVehicleDetail';
import TransportDrivers from './pages/transport/TransportDrivers';
import TransportDriverDetail from './pages/transport/TransportDriverDetail';
import DriverLayout from './components/layout/DriverLayout';
import DriverLogin from './pages/driver/DriverLogin';
import DriverDashboard from './pages/driver/DriverDashboard';
import DriverExpenses from './pages/driver/DriverExpenses';
import DriverProfile from './pages/driver/DriverProfile';

// Teacher Portal
import TeacherLogin from './pages/teacher/TeacherLogin';

// Finance Portal
import FinanceLogin from './pages/finance/FinanceLogin';

// Food Portal
import FoodLogin from './pages/food/FoodLogin';

// Transport Portal
import TransportLogin from './pages/transport/TransportLogin';

import TeacherLayout from './components/layout/TeacherLayout';
import TeacherProfile from './pages/teacher/TeacherProfile';
import TeacherClasses from './pages/teacher/TeacherClasses';
import TeacherAttendance from './pages/teacher/TeacherAttendance';
import TeacherSchedule from './pages/teacher/TeacherSchedule';
import TeacherStudentDetail from './pages/teacher/TeacherStudentDetail';
import TeacherAcademics from './pages/teacher/TeacherAcademics';
import TeacherRequests from './pages/teacher/TeacherRequests';


import Salaries from './pages/finance/Salaries';
import FoodFinance from './pages/finance/FoodFinance';
import TransportFinance from './pages/finance/TransportFinance';
import FinanceExpenses from './pages/finance/FinanceExpenses';
import { SchoolProvider } from './context/SchoolContext';


function App() {
  // Initialize theme on app load
  useEffect(() => {
    const theme = localStorage.getItem('theme') || 'light';

    if (theme === 'dark') {
      document.documentElement.classList.add('dark');
    } else if (theme === 'auto') {
      // Check system preference
      if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
        document.documentElement.classList.add('dark');
      }
    } else {
      document.documentElement.classList.remove('dark');
    }

    // Listen for system theme changes when in auto mode
    const mediaQuery = window.matchMedia('(prefers-color-scheme: dark)');
    const handleChange = (e) => {
      if (localStorage.getItem('theme') === 'auto') {
        if (e.matches) {
          document.documentElement.classList.add('dark');
        } else {
          document.documentElement.classList.remove('dark');
        }
      }
    };

    mediaQuery.addEventListener('change', handleChange);
    return () => mediaQuery.removeEventListener('change', handleChange);
  }, []);

  return (
    <SchoolProvider>
      <Router>
        <React.Suspense fallback={null}>
          <Routes>
            <Route path="/login" element={<Login />} />
            <Route path="/driver-login" element={<DriverLogin />} />
            <Route path="/teacher-login" element={<TeacherLogin />} />
            <Route path="/finance-login" element={<FinanceLogin />} />
            <Route path="/food-login" element={<FoodLogin />} />
            <Route path="/transport-login" element={<TransportLogin />} />

            {/* Protected Admin Area - Superuser Only */}
            <Route element={<SuperuserRoute />}>
              <Route element={<DashboardLayout />}>
                <Route path="/dashboard" element={<Dashboard />} />
                <Route path="/students" element={<Students />} />
                <Route path="/students/create" element={<StudentCreate />} />
                <Route path="/students/:id" element={<StudentDetail />} />
                <Route path="/students/:id/edit" element={<StudentEdit />} />
                <Route path="/students/:id/academic-report" element={<StudentAcademicReport />} />
                <Route path="/teachers" element={<Teachers />} />
                <Route path="/teachers/create" element={<TeacherCreate />} />
                <Route path="/teachers/:id" element={<TeacherDetail />} />
                <Route path="/teachers/:id/schedule" element={<TeacherScheduleManage />} />
                <Route path="/finance" element={<Finance />} />
                <Route path="/finance/transactions" element={<Transactions />} />
                <Route path="/finance/record" element={<PaymentRecord />} />
                <Route path="/finance/transport-expenses" element={<TransportFinance />} />
                <Route path="/finance/salaries" element={<Salaries />} />
                <Route path="/schedule" element={<Schedule />} />
                <Route path="/academics" element={<Academics />} />
                <Route path="/academic-management" element={<AcademicManagement />} />
                <Route path="/hr/staff" element={<HRStaff />} />
                <Route path="/hr/staff/create" element={<StaffCreate />} />
                <Route path="/hr/staff/:id/edit" element={<StaffEdit />} />
                <Route path="/hr/staff/:id" element={<StaffDetail />} />
                <Route path="/hr/approvals" element={<HRApprovals />} />
                <Route path="/hr/supervisors" element={<Supervisors />} />
                <Route path="/settings" element={<Settings />} />
                <Route path="/" element={<Navigate to="/dashboard" replace />} />
              </Route>
            </Route>

            {/* Other Protected Routes */}
            <Route element={<ProtectedRoute />}>

              {/* Finance Independent Portal */}
              <Route path="/finance-portal" element={<FinanceLayout />}>
                <Route path="dashboard" element={<FinancePortalDashboard />} />
                <Route path="accounts" element={<FinancePortalAccounts />} />
                <Route path="accounts/:id" element={<FinancePortalStudentDetail />} />
                <Route path="transactions" element={<FinancePortalTransactions />} />
                <Route path="transactions/:id" element={<FinancePortalTransactionDetail />} />
                <Route path="reports" element={<FinancePortalReports />} />
                <Route path="transport-expenses" element={<TransportFinance />} />
                <Route path="salaries" element={<Salaries />} />
                <Route path="food" element={<FoodFinance />} />
                <Route path="expenses" element={<FinanceExpenses />} />
                {/* Redirect root of portal to dashboard */}
                <Route index element={<Navigate to="dashboard" replace />} />
              </Route>

              {/* Food Management Portal */}
              <Route path="/food-portal" element={<FoodLayout />}>
                <Route index element={<Navigate to="dashboard" replace />} />
                <Route path="dashboard" element={<FoodDashboard />} />
                <Route path="students" element={<FoodStudentList />} />
                <Route path="students/:id" element={<FoodStudentDetail />} />
                <Route path="menu" element={<FoodMealOptions />} />
                <Route path="serving-list" element={<FoodServingList />} />
              </Route>

              {/* Transport Management Portal */}
              <Route path="/transport-portal" element={<TransportLayout />}>
                <Route index element={<Navigate to="dashboard" replace />} />
                <Route path="dashboard" element={<TransportDashboard />} />
                <Route path="students" element={<TransportStudentList />} />
                <Route path="students/:id" element={<TransportStudentDetail />} />
                <Route path="routes" element={<TransportRoutes />} />
                <Route path="routes/:id" element={<TransportRouteDetail />} />
                <Route path="vehicles" element={<TransportVehicles />} />
                <Route path="vehicles/:id" element={<TransportVehicleDetail />} />
                <Route path="drivers" element={<TransportDrivers />} />
                <Route path="drivers/:id" element={<TransportDriverDetail />} />
              </Route>

              {/* Driver Portal */}
              <Route path="/driver-portal" element={<DriverLayout />}>
                <Route path="dashboard" element={<DriverDashboard />} />
                <Route path="expenses" element={<DriverExpenses />} />
                <Route path="profile" element={<DriverProfile />} />
              </Route>

              {/* Teacher Portal Routes */}
              <Route path="/teacher/:id" element={<TeacherLayout />}>
                <Route index element={<TeacherProfile />} />
                <Route path="class" element={<TeacherClasses />} />
                <Route path="student/:id" element={<TeacherStudentDetail />} />
                <Route path="student/:id/report" element={<StudentAcademicReport />} />
                <Route path="academics" element={<TeacherAcademics />} />
                <Route path="attendance" element={<TeacherAttendance />} />
                <Route path="schedule" element={<TeacherSchedule />} />
                <Route path="requests" element={<TeacherRequests />} />
              </Route>
              <Route path="/teacher-portal" element={<Navigate to="/teacher-login" replace />} />



            </Route>
          </Routes>
        </React.Suspense>
      </Router>
    </SchoolProvider>
  );
}

export default App;
