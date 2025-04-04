
import React from "react";
import { cn } from "@/lib/utils";

interface StatusBadgeProps {
  status: "Good" | "Progress" | "Deteriorate";
  className?: string;
}

const StatusBadge: React.FC<StatusBadgeProps> = ({ status, className }) => {
  const getStatusClass = () => {
    switch (status) {
      case "Good":
        return "bg-green-500 text-white";
      case "Progress":
        return "bg-yellow-500 text-white";
      case "Deteriorate":
        return "bg-red-500 text-white";
      default:
        return "bg-gray-500 text-white";
    }
  };

  return (
    <span
      className={cn(
        "px-2 py-1 text-xs rounded-full font-medium",
        getStatusClass(),
        className
      )}
    >
      {status}
    </span>
  );
};

export default StatusBadge;
