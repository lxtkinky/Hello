# Hello

Gitlab 项目迁移（同一个用户下进行迁移）
1、clone项目到本地并检出分支
git clone http://gitlab.huiduola.net:8888/lxtkinky/Demo.git
git checkout -b branch1 origin/branch1
git checkout -b branch2 origin/branch2
2、修改本地URL指向（三种方式）
（1）git remote set-url origin http://gitlab.huiduola.net:8888/lxtkinky/test-qianyi.git
（2）git remote rm origin 
git remote add origin http://gitlab.huiduola.net:8888/lxtkinky/test-qianyi.git
(3)修改config文件（未尝试）
3、把本地仓库推送到新的远程仓库
git push origin master:master
git push origin branch1:branch1
git push origin branch2:branch2
