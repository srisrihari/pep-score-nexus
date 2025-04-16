import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { Card, CardContent, CardHeader, CardTitle, CardDescription, CardFooter } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Separator } from "@/components/ui/separator";
import { toast } from "sonner";
import { 
  MessageSquare, 
  Send, 
  User, 
  Clock, 
  Filter,
  CheckCircle,
  AlertCircle,
  Search,
  ArrowUpDown,
  Calendar
} from "lucide-react";

// Mock feedback data
const feedbackData = [
  {
    id: 1,
    studentId: "2024-Ajith",
    studentName: "Ajith",
    registrationNo: "2334",
    date: "2023-04-15",
    subject: "Wellness Assessment Feedback",
    message: "Great improvement in your fitness levels. Your push-ups and sit-ups scores have significantly improved. Keep up the good work!",
    status: "unread",
    quadrant: "wellness"
  },
  {
    id: 2,
    studentId: "2024-Rohan",
    studentName: "Rohan S",
    registrationNo: "2335",
    date: "2023-04-14",
    subject: "Improvement Areas",
    message: "You need to focus more on your flexibility. Your sit and reach scores are below average. I recommend daily stretching exercises.",
    status: "read",
    quadrant: "wellness"
  },
  {
    id: 3,
    studentId: "2024-Priya",
    studentName: "Priya M",
    registrationNo: "2361",
    date: "2023-04-13",
    subject: "Wellness Plan",
    message: "Based on your recent assessment, I've created a personalized wellness plan for you. Please follow it consistently for better results.",
    status: "read",
    quadrant: "wellness"
  },
  {
    id: 4,
    studentId: "2024-Kavita",
    studentName: "Kavita R",
    registrationNo: "2362",
    date: "2023-04-12",
    subject: "Attendance Concern",
    message: "Your attendance in wellness sessions has been inconsistent. This is affecting your performance. Please ensure regular attendance.",
    status: "unread",
    quadrant: "wellness"
  },
  {
    id: 5,
    studentId: "2024-Arjun",
    studentName: "Arjun K",
    registrationNo: "2363",
    date: "2023-04-11",
    subject: "Outstanding Performance",
    message: "Congratulations on your outstanding performance in the recent fitness assessment. You've scored the highest in your batch!",
    status: "read",
    quadrant: "wellness"
  }
];

const TeacherFeedback: React.FC = () => {
  const navigate = useNavigate();
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedTab, setSelectedTab] = useState("all");
  const [selectedFeedback, setSelectedFeedback] = useState<typeof feedbackData[0] | null>(null);
  const [replyText, setReplyText] = useState("");
  const [newFeedbackSubject, setNewFeedbackSubject] = useState("");
  const [newFeedbackMessage, setNewFeedbackMessage] = useState("");
  const [selectedStudent, setSelectedStudent] = useState("");
  
  // Filter feedback based on search query and tab
  const filteredFeedback = feedbackData.filter(feedback => {
    const matchesSearch = 
      feedback.studentName.toLowerCase().includes(searchQuery.toLowerCase()) ||
      feedback.subject.toLowerCase().includes(searchQuery.toLowerCase());
    
    const matchesTab = 
      selectedTab === "all" || 
      (selectedTab === "unread" && feedback.status === "unread") ||
      (selectedTab === "sent" && feedback.status === "read");
    
    return matchesSearch && matchesTab;
  });
  
  // Handle sending a reply
  const handleSendReply = () => {
    if (!replyText.trim()) {
      toast.error("Please enter a reply message");
      return;
    }
    
    toast.success("Reply sent successfully");
    setReplyText("");
    // In a real app, you would update the feedback status and add the reply to the conversation
  };
  
  // Handle sending new feedback
  const handleSendNewFeedback = () => {
    if (!selectedStudent) {
      toast.error("Please select a student");
      return;
    }
    
    if (!newFeedbackSubject.trim()) {
      toast.error("Please enter a subject");
      return;
    }
    
    if (!newFeedbackMessage.trim()) {
      toast.error("Please enter a message");
      return;
    }
    
    toast.success("Feedback sent successfully");
    setNewFeedbackSubject("");
    setNewFeedbackMessage("");
    setSelectedStudent("");
    // In a real app, you would add the new feedback to the list
  };

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold">Feedback Management</h1>
        <p className="text-muted-foreground">
          Manage and send feedback to your students
        </p>
      </div>

      <Tabs defaultValue="inbox" className="w-full">
        <TabsList className="grid w-full grid-cols-2">
          <TabsTrigger value="inbox">Inbox</TabsTrigger>
          <TabsTrigger value="compose">Compose New</TabsTrigger>
        </TabsList>
        
        <TabsContent value="inbox" className="space-y-4 mt-4">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div className="md:col-span-1">
              <Card className="h-full">
                <CardHeader className="pb-2">
                  <div className="flex justify-between items-center">
                    <CardTitle>Messages</CardTitle>
                    <Badge>{feedbackData.filter(f => f.status === "unread").length} Unread</Badge>
                  </div>
                  <div className="relative mt-2">
                    <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
                    <Input
                      type="search"
                      placeholder="Search messages..."
                      className="pl-8"
                      value={searchQuery}
                      onChange={(e) => setSearchQuery(e.target.value)}
                    />
                  </div>
                  <Tabs defaultValue="all" value={selectedTab} onValueChange={setSelectedTab} className="mt-2">
                    <TabsList className="grid w-full grid-cols-3">
                      <TabsTrigger value="all">All</TabsTrigger>
                      <TabsTrigger value="unread">Unread</TabsTrigger>
                      <TabsTrigger value="sent">Sent</TabsTrigger>
                    </TabsList>
                  </Tabs>
                </CardHeader>
                <CardContent className="h-[calc(100%-130px)] overflow-auto">
                  <div className="space-y-2">
                    {filteredFeedback.length > 0 ? (
                      filteredFeedback.map((feedback) => (
                        <div 
                          key={feedback.id} 
                          className={`p-3 rounded-md cursor-pointer transition-colors ${
                            selectedFeedback?.id === feedback.id 
                              ? 'bg-primary text-primary-foreground' 
                              : feedback.status === 'unread' 
                                ? 'bg-muted hover:bg-muted/80' 
                                : 'hover:bg-muted/50'
                          }`}
                          onClick={() => setSelectedFeedback(feedback)}
                        >
                          <div className="flex justify-between items-start">
                            <div className="font-medium">{feedback.studentName}</div>
                            <div className="text-xs">
                              {new Date(feedback.date).toLocaleDateString()}
                            </div>
                          </div>
                          <div className="text-sm truncate">{feedback.subject}</div>
                          <div className="text-xs truncate mt-1">
                            {feedback.message.substring(0, 60)}...
                          </div>
                          {feedback.status === "unread" && (
                            <div className="flex justify-end mt-1">
                              <div className="w-2 h-2 rounded-full bg-primary"></div>
                            </div>
                          )}
                        </div>
                      ))
                    ) : (
                      <div className="text-center py-8 text-muted-foreground">
                        No messages found
                      </div>
                    )}
                  </div>
                </CardContent>
              </Card>
            </div>
            
            <div className="md:col-span-2">
              <Card className="h-full">
                {selectedFeedback ? (
                  <>
                    <CardHeader>
                      <div className="flex justify-between items-start">
                        <div>
                          <CardTitle>{selectedFeedback.subject}</CardTitle>
                          <CardDescription className="flex items-center mt-1">
                            <span className="font-medium">{selectedFeedback.studentName}</span>
                            <span className="mx-2">•</span>
                            <span>{selectedFeedback.registrationNo}</span>
                            <span className="mx-2">•</span>
                            <span>{new Date(selectedFeedback.date).toLocaleDateString()}</span>
                          </CardDescription>
                        </div>
                        <Badge variant="outline">{selectedFeedback.quadrant}</Badge>
                      </div>
                    </CardHeader>
                    <CardContent>
                      <div className="space-y-4">
                        <div className="p-4 rounded-lg bg-muted/50">
                          <p>{selectedFeedback.message}</p>
                        </div>
                        
                        <Separator />
                        
                        <div className="space-y-2">
                          <Label htmlFor="reply">Reply</Label>
                          <Textarea
                            id="reply"
                            placeholder="Type your reply here..."
                            value={replyText}
                            onChange={(e) => setReplyText(e.target.value)}
                            className="min-h-[120px]"
                          />
                        </div>
                      </div>
                    </CardContent>
                    <CardFooter className="flex justify-end">
                      <Button onClick={handleSendReply}>
                        <Send className="mr-2 h-4 w-4" />
                        Send Reply
                      </Button>
                    </CardFooter>
                  </>
                ) : (
                  <div className="flex items-center justify-center h-full p-8">
                    <div className="text-center">
                      <MessageSquare className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
                      <h3 className="text-lg font-medium">No message selected</h3>
                      <p className="text-muted-foreground">
                        Select a message from the list to view its contents
                      </p>
                    </div>
                  </div>
                )}
              </Card>
            </div>
          </div>
        </TabsContent>
        
        <TabsContent value="compose" className="space-y-4 mt-4">
          <Card>
            <CardHeader>
              <CardTitle>Compose New Feedback</CardTitle>
              <CardDescription>
                Send feedback or assessment notes to a student
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="student">Student</Label>
                <Select value={selectedStudent} onValueChange={setSelectedStudent}>
                  <SelectTrigger id="student">
                    <SelectValue placeholder="Select a student" />
                  </SelectTrigger>
                  <SelectContent>
                    {feedbackData.map(feedback => (
                      <SelectItem key={feedback.studentId} value={feedback.studentId}>
                        {feedback.studentName} ({feedback.registrationNo})
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
              
              <div className="space-y-2">
                <Label htmlFor="subject">Subject</Label>
                <Input
                  id="subject"
                  placeholder="Enter subject"
                  value={newFeedbackSubject}
                  onChange={(e) => setNewFeedbackSubject(e.target.value)}
                />
              </div>
              
              <div className="space-y-2">
                <Label htmlFor="message">Message</Label>
                <Textarea
                  id="message"
                  placeholder="Type your feedback message here..."
                  value={newFeedbackMessage}
                  onChange={(e) => setNewFeedbackMessage(e.target.value)}
                  className="min-h-[200px]"
                />
              </div>
              
              <div className="space-y-2">
                <Label>Related Assessment</Label>
                <Select>
                  <SelectTrigger>
                    <SelectValue placeholder="Select related assessment (optional)" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="wellness-term1">Wellness Assessment - Term 1</SelectItem>
                    <SelectItem value="wellness-term2">Wellness Assessment - Term 2</SelectItem>
                    <SelectItem value="wellness-term3">Wellness Assessment - Term 3</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </CardContent>
            <CardFooter className="flex justify-between">
              <Button variant="outline" onClick={() => {
                setNewFeedbackSubject("");
                setNewFeedbackMessage("");
                setSelectedStudent("");
              }}>
                Clear
              </Button>
              <Button onClick={handleSendNewFeedback}>
                <Send className="mr-2 h-4 w-4" />
                Send Feedback
              </Button>
            </CardFooter>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
};

export default TeacherFeedback;
