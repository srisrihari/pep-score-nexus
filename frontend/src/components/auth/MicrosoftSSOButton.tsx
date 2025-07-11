import React, { useState } from 'react';
import { Button } from '@/components/ui/button';
import { toast } from 'sonner';
import { Loader2 } from 'lucide-react';

interface MicrosoftSSOButtonProps {
  onSuccess?: (result: any) => void;
  onError?: (error: any) => void;
  disabled?: boolean;
  className?: string;
}

const MicrosoftSSOButton: React.FC<MicrosoftSSOButtonProps> = ({
  onSuccess,
  onError,
  disabled = false,
  className = ''
}) => {
  const [isLoading, setIsLoading] = useState(false);

  const handleMicrosoftLogin = async () => {
    try {
      setIsLoading(true);
      console.log('🚀 Microsoft SSO: Redirecting to backend login...');

      // Redirect to backend Microsoft SSO endpoint
      window.location.href = 'http://localhost:3001/api/v1/auth/microsoft/login';

    } catch (error: any) {
      console.error('❌ Microsoft SSO Error:', error);

      toast.error('Failed to initiate Microsoft SSO login');

      // Call error callback
      if (onError) {
        onError(error);
      }

      setIsLoading(false);
    }
  };

  return (
    <Button
      type="button"
      variant="outline"
      className={`w-full flex items-center justify-center gap-2 ${className}`}
      onClick={handleMicrosoftLogin}
      disabled={disabled || isLoading}
    >
      {isLoading ? (
        <Loader2 className="h-4 w-4 animate-spin" />
      ) : (
        <svg
          className="h-4 w-4"
          viewBox="0 0 23 23"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path d="M11 11h11V0H11v11z" fill="#f25022" />
          <path d="M0 11h11V0H0v11z" fill="#00a4ef" />
          <path d="M11 22h11V11H11v11z" fill="#ffb900" />
          <path d="M0 22h11V11H0v11z" fill="#7fba00" />
        </svg>
      )}
      {isLoading ? 'Signing in...' : 'Sign in with Microsoft'}
    </Button>
  );
};

export default MicrosoftSSOButton;
