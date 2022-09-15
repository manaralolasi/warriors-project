pipeline {

	agent any

	environment {
		AWS_ACCESS_KEY_ID     = credentials('Access_key_ID')
  		AWS_SECRET_ACCESS_KEY = credentials('Secret_access_key')
		AWS_S3_BUCKET = 'book22'
		AWS_EB_APP_NAME = 'mmmmmmm'
        AWS_EB_ENVIRONMENT_NAME = 'Mmmmmmm-env'
        AWS_EB_APP_VERSION = "${BUILD_ID}"
	}

	stages {      
	stage('Build'){
            steps {
                sh "mvn clean"

                sh "mvn compile"
            }
        }

        stage('Test'){
            steps {
                sh "mvn test"
            }

            post {
                always {
                    junit '**/target/surefire-reports/TEST-*.xml'
                }
            }
        }

        stage('sonar scan'){
            steps {
              sh "mvn clean verify sonar:sonar \"
   mvn sonar:sonar \
  -Dsonar.host.url=http://3.21.40.19:9000 \
  -Dsonar.login=59474a2dfe0b653533baad039f3a2dc2aa7f0136
            }
        }


        stage('Deploy') {
            steps {
                sh 'aws configure set region us-east-2	'
                sh 'aws elasticbeanstalk create-application-version --application-name $AWS_EB_APP_NAME --version-label $AWS_EB_APP_VERSION --source-bundle S3Bucket=$AWS_S3_BUCKET,S3Key=$ARTIFACT_NAME'
                sh 'aws elasticbeanstalk update-environment --application-name $AWS_EB_APP_NAME --environment-name $AWS_EB_ENVIRONMENT_NAME --version-label $AWS_EB_APP_VERSION'
            }
	}
    }
}
