A Sample application that shows why we need to use multi-stage builds. 
Both Docker images are built as

docker build -f <nameofDockerfile> -t <nameofImage> . 

Both do the same - observe the size of the built images. 