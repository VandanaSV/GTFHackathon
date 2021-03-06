echo "-------------------------------------------------------------------------------------------------------"
echo "################ CODE COVERAGE TOOL ###############################"
echo "-------------------------------------------------------------------------------------------------------"

echo "-------------------------------------------------------------------------------------------------------"
echo "############## Application starts with the jacoco agent ###########"
echo "-------------------------------------------------------------------------------------------------------"
java -javaagent:libraries/org.jacoco.agent-0.8.6-runtime.jar=address=0.0.0.0,port=36320,destfile=exec/jacoco-it.exec,output=tcpserver -jar libraries/application-jar/target/SampleApp-1.0.0-spring-boot.jar&
sleep 10
echo "-------------------------------------------------------------------------------------------------------"
echo "############# Automation script starts execution ##############"
echo "-------------------------------------------------------------------------------------------------------"
mvn test
sleep 5
echo "-------------------------------------------------------------------------------------------------------"
echo "######### Jacoco cli dumps all the coverage execution data to the exec file ##########"
echo "-------------------------------------------------------------------------------------------------------"
java -jar libraries/jacococli.jar dump --address localhost --port 36320  --reset --destfile exec/jacoco-it.exec
sleep 5
echo "-------------------------------------------------------------------------------------------------------"
echo "######### Application class files are derived from jar file for coverage report generation ##########"
echo "-------------------------------------------------------------------------------------------------------"
mkdir Application
cp libraries/application-jar/target/* Application
cd Application
jar xf SampleApp-1.0.0-spring-boot.jar 
jar xf SampleApp-1.0.0-sources.jar
classfiles='Application/BOOT-INF/classes/com'
sourcefiles='Application'
mkdir java
mv com java/
echo "-------------------------------------------------------------------------------------------------------"
echo "######### Jacoco cli converts the exec to html format analyzing the application class files ##########"
echo "-------------------------------------------------------------------------------------------------------"
cd ..
java -jar libraries/jacococli.jar report exec/jacoco-it.exec --classfiles $classfiles --sourcefiles $sourcefiles/java --html code-coverage-report/

echo "-------------------------------------------------------------------------------------------------------"
echo "######### Uploading code coverage report to Jira story ##########"
echo "-------------------------------------------------------------------------------------------------------"
mv code-coverage-report/index.html code-coverage-report/code-coverage-report.html
zip -r code-coverage-report.zip code-coverage-report

JiraId='PF-1'
Accesstoken='dmFuZGFuYXN2b25AZ21haWwuY29tOlFvczMwWkdHd2psc05YS2pFQXg2NTgzQw=='
curl 	-X POST \
	-H "X-Atlassian-Token:no-check" \
	-H "Authorization:Basic $Accesstoken" \
	-F "file=@code-coverage-report.zip" \
	https://hackathon-poc.atlassian.net/rest/api/3/issue/$JiraId/attachments


kill $(lsof -t -i:8080)









