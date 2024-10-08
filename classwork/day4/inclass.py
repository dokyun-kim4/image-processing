import cv2 as cv

img = cv.imread("plane.jpeg")

b_channel, g_channel, r_channel = img[:,:,0],img[:,:,1],img[:,:,2]
cv.imshow('orig', img)
cv.imshow('B', b_channel)
cv.imshow('G', g_channel)
cv.imshow('R', r_channel)


img_hsv = cv.cvtColor(img, cv.COLOR_BGR2HSV)


cv.waitKey(0)
