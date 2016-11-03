AGENT_ENV=$1
AGENT_PATH=$(pwd)/agent
nohup ruby $AGENT_PATH/init.rb $AGENT_ENV $KEY>$AGENT_PATH/log/runner.log  

echo '----------------------------------------------------'
echo 'Agent Initiated!                        '$AGENT_ENV
echo '----------------------------------------------------'
echo 'Run the following command to find the agent process'
echo 'ps -ax | grep agent/init.rb'
echo '----------------------------------------------------'