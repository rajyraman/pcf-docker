docker build --pull --rm -t pcf:latest .
docker run -it -v $pwd\src:c:\src --name TestComponent -p 8181:8181  --env-file pcf.env  pcf:latest --rm