
import React, { useState, useEffect } from "react";
import { useNavigate, useSearchParams } from "react-router-dom";
import { useAuth } from "@/contexts/AuthContext";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { BarChart3, Lock, User, AlertCircle } from "lucide-react";
import { toast } from "sonner";
import MicrosoftSSOButton from "@/components/auth/MicrosoftSSOButton";

const Login: React.FC = () => {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const { login, loginWithSSO, isAuthenticated, userRole } = useAuth();
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();

  // Handle SSO errors from URL parameters
  useEffect(() => {
    const error = searchParams.get('error');
    const message = searchParams.get('message');

    if (error) {
      const errorMessage = message ? decodeURIComponent(message) : 'Authentication failed';
      toast.error(errorMessage);

      // Clear error parameters from URL
      navigate('/login', { replace: true });
    }
  }, [searchParams, navigate]);

  // Redirect if already authenticated
  useEffect(() => {
    if (isAuthenticated && userRole) {
      switch (userRole) {
        case 'admin':
          navigate("/admin");
          break;
        case 'teacher':
          navigate("/teacher");
          break;
        case 'student':
          navigate("/student");
          break;
      }
    }
  }, [isAuthenticated, userRole, navigate]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!username || !password) {
      toast.error("Please enter both username and password");
      return;
    }

    setIsLoading(true);

    try {
      const success = await login(username, password);
      // Redirection will be handled by the useEffect hook
      // once the auth context is updated with the user role
    } finally {
      setIsLoading(false);
    }
  };

  const handleMicrosoftSSOSuccess = async (result: any) => {
    console.log('✅ Microsoft SSO Success:', result);

    try {
      const success = await loginWithSSO(result);
      if (success) {
        // Redirection will be handled by the useEffect hook
        // once the auth context is updated with the user role
        console.log('✅ SSO login successful, waiting for redirect...');
      }
    } catch (error) {
      console.error('❌ SSO login processing error:', error);
      toast.error('Failed to process SSO login');
    }
  };

  const handleMicrosoftSSOError = (error: any) => {
    console.error('❌ Microsoft SSO Error:', error);
    // Error is already handled by the MicrosoftSSOButton component
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-primary/20 to-secondary/20 p-4">
      <Card className="w-full max-w-md shadow-xl">
        <CardHeader className="text-center pb-2">
          <div className="flex justify-center mb-4">
            <div className="p-4 rounded-full bg-primary/10">
              <BarChart3 className="h-10 w-10 text-primary" />
            </div>
          </div>
          <CardTitle className="text-2xl font-bold">PEP Score Nexus</CardTitle>
          <p className="text-muted-foreground">Personality Enhancement Program</p>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="space-y-2">
              <div className="relative">
                <User className="absolute left-3 top-3 h-4 w-4 text-muted-foreground" />
                <Input
                  type="text"
                  placeholder="Username"
                  className="pl-10"
                  value={username}
                  onChange={(e) => setUsername(e.target.value)}
                />
              </div>
            </div>
            <div className="space-y-2">
              <div className="relative">
                <Lock className="absolute left-3 top-3 h-4 w-4 text-muted-foreground" />
                <Input
                  type="password"
                  placeholder="Password"
                  className="pl-10"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                />
              </div>
            </div>
            <Button
              type="submit"
              className="w-full"
              disabled={isLoading}
            >
              {isLoading ? "Logging in..." : "Login"}
            </Button>
          </form>

          {/* Microsoft SSO Section */}
          <div className="relative my-6">
            <div className="absolute inset-0 flex items-center">
              <span className="w-full border-t" />
            </div>
            <div className="relative flex justify-center text-xs uppercase">
              <span className="bg-background px-2 text-muted-foreground">
                Or continue with
              </span>
            </div>
          </div>

          <MicrosoftSSOButton
            onSuccess={handleMicrosoftSSOSuccess}
            onError={handleMicrosoftSSOError}
            disabled={isLoading}
            className="mb-4"
          />

          <div className="text-center text-xs text-muted-foreground mb-4">
            <div className="flex items-center justify-center gap-1">
              <AlertCircle className="h-3 w-3" />
              <span>Use your @vijaybhoomi.edu.in email for SSO login</span>
            </div>
          </div>

          <div className="mt-6 text-center text-sm text-muted-foreground">
            <p>Demo Credentials:</p>
            <div className="grid grid-cols-3 gap-2 mt-2">
              <div className="bg-muted p-2 rounded-md">
                <p className="font-medium">Student</p>
                <p>Username: student1</p>
                <p>Password: password123</p>
              </div>
              <div className="bg-muted p-2 rounded-md">
                <p className="font-medium">Teacher</p>
                <p>Username: teacher1</p>
                <p>Password: password123</p>
              </div>
              <div className="bg-muted p-2 rounded-md">
                <p className="font-medium">Admin</p>
                <p>Username: admin1</p>
                <p>Password: password123</p>
              </div>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  );
};

export default Login;
