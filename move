#! /usr/bin/env python



import rospy
from nav_msgs.msg import Odometry
from geometry_msgs.msg import Twist

x = 0.0

def newOdom(msg):
    global x
    x = msg.pose.pose.position.x
    rospy.loginfo(x)
   
rospy.init_node("speed_controller")

sub = rospy.Subscriber("/odometry", Odometry, newOdom)
pub = rospy.Publisher("/cmd_vel", Twist, queue_size = 1)

speed = Twist()

r = rospy.Rate(1)

goal_x = 2.0

while not rospy.is_shutdown():

    dis = goal_x-x
    if dis>0 : 
        speed.linear.x = 0.5
        speed.angular.z = 0.0

    else:
        speed.linear.x = 0.0
        speed.angular.z = 0.3

    

    pub.publish(speed)
    speed.angular.z = 0
    speed.linear.x = 0
    pub.publish(speed)


    r.sleep()
