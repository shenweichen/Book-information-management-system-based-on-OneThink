#-*- coding:utf-8 -*-
from numpy import *
from numpy import linalg as la


    
def ecludSim(inA,inB):
    return 1.0/(1.0 + la.norm(inA - inB))#欧几里得相似度

def pearsSim(inA,inB):
    if len(inA) < 3 : return 1.0
    return 0.5+0.5*corrcoef(inA, inB, rowvar = 0)[0][1]#皮尔逊相似度

def cosSim(inA,inB):#余弦相似度
    num = float(inA.T*inB)
    denom = la.norm(inA)*la.norm(inB)
    return 0.5+0.5*(num/denom)

def standEst(dataMat, user, simMeas, item):#评分预测
    """计算用户对图书的估计评分值

    :param dataMat: 用户评分矩阵
    :param user: 用户编号
    :param simMeas: 相似度计算方法
    :param item: 待评分书籍编号
    :return: 预测评分值
    """
    n = shape(dataMat)[1]# n为图书的数目
    simTotal = 0.0; ratSimTotal = 0.0
    for j in range(n):
        userRating = dataMat[user,j]
        if userRating == 0: continue
        overLap = nonzero(logical_and(dataMat[:,item].A>0, \
                                      dataMat[:,j].A>0))[0]  #寻找两本用户都评分过的图书
        if len(overLap) == 0: similarity = 0#如果两个用户都共同评分图书为0，那么相似度为0
        else: similarity = simMeas(dataMat[overLap,item], \
                                   dataMat[overLap,j])      #计算两个图书的相似度
        #print 'the %d and %d similarity is: %f' % (item, j, similarity)
        simTotal += similarity
        ratSimTotal += similarity * userRating
    if simTotal == 0: return 0
    else: return ratSimTotal/simTotal #归一化


def recommend(dataMat, user, N=3, simMeas=cosSim, estMethod=standEst):
    """推荐引擎

    :param dataMat: 用户评分矩阵
    :param user: 待推荐用户
    :param N: 参数
    :param simMeas: 相似度计算方法
    :param estMethod: 评分预测方法
    :return: 推荐的图书列表
    """
    unratedItems = nonzero(dataMat[user,:].A==0)[1]#建立一个未评分的图书列表
    if len(unratedItems) == 0: return 'you rated everything'
    itemScores = []
    for item in unratedItems:
        estimatedScore = estMethod(dataMat, user, simMeas, item)#对所有未评分的图书产生预测评分
        itemScores.append((item, estimatedScore))
    return sorted(itemScores, key=lambda jj: jj[1], reverse=True)[:N]#返回前N个未评分过的图书

def printMat(inMat, thresh=0.8):
    for i in range(32):
        for k in range(32):
            if float(inMat[i,k]) > thresh:
                print 1,
            else: print 0,
        print ''
