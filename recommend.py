#-*- coding:utf-8 -*-
import svdRec
import numpy as np
from numpy import *
import MySQLdb
import sys


def loadMatrixFromMysql(conn):
	cur = conn.cursor()
	cur.execute("select count(*) from ot_book")#读取书本的总数
	totalbook=cur.fetchone()[0];
	cur.execute("select count(*) from ot_member")#读取用户总数
	totaluser=cur.fetchone()[0];
	cur.execute("select * from ot_score")#读取所有的评分信息
	temp = cur.fetchall()
	a = np.zeros(shape=(totaluser,totalbook))#构造一个用户数*书本数的评分矩阵并初始化为零
	for isbn_id,user_id,value in temp:
		a[user_id-1,isbn_id-1]=value#将用户的评分填入矩阵
	cur.close()
	return a

def saveToMysql(conn,data):
	cur=conn.cursor()
	cur.execute('truncate table ot_recommend')#清空推荐表
	print data
	for item in data:
		book_id=[int(item[0])+1]
		cur.execute('insert into ot_recommend  values (%s)',book_id)#将推荐结果插入到推荐表
	cur.close()
	return


conn= MySQLdb.Connect(
host = '127.0.0.1',
port = 3306,
user = 'root',
passwd = '',
db = 'onethink',
charset = 'utf8'
)


myMat=mat(loadMatrixFromMysql(conn))

#print myMat

# print svdRec.ecludSim(myMat[:,0],myMat[:,1])
# print svdRec.ecludSim(myMat[:,0],myMat[:,0])

# print svdRec.cosSim(myMat[:,0],myMat[:,1])
# print svdRec.cosSim(myMat[:,0],myMat[:,0])

# print svdRec.pearsSim(myMat[:,0],myMat[:,1])
# print svdRec.pearsSim(myMat[:,0],myMat[:,0])

data=svdRec.recommend(myMat,sys.argv[1])#sys.argv[1] ,为当前用户推荐
# print svdRec.recommend(myMat,5,simMeas=svdRec.ecludSim)
# print svdRec.recommend(myMat,5,simMeas=svdRec.pearsSim)


saveToMysql(conn,data)  
conn.commit()
conn.close()