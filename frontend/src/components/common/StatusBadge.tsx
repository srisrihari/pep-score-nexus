
import React from "react";
import { cn } from "@/lib/utils";

export type StatusType = "Good" | "Progress" | "Deteriorate" | "Cleared" | "Not Cleared" | "Attendance Shortage";

interface StatusBadgeProps {
  status: StatusType;
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
      case "Cleared":
        return "bg-blue-500 text-white";
      case "Not Cleared":
        return "bg-orange-500 text-white";
      case "Attendance Shortage":
        return "bg-purple-500 text-white";
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
