@echo off 
FOR %%A IN (1,2,3,4,5) DO docker run --rm --name ubuntu%%A -itd ubuntu