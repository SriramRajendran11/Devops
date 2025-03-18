# Verify we can pull code from Github wiht no issues or password prompts
rm -rf demorepos # somebody might have run this job or created a folder with samename cleanup
git clone git@github.com:seshagirisriram/demorepos.git
rm -rf demorepos # They may never run this job again -clean up
# Docker checks
docker version # prints version of docker
echo $USER with password $PASSWORD  # verify no user or password is shownn
echo $PASSWORD | docker login -u $USER --password-stdin
docker logout #simple login and lgout
