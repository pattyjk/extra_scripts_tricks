## For zip files

```
#!/bin/bash

for i in ./*/
do
        cd "$i";
        unzip *.zip;
        cd ../;
done
```

## For GZ files
```
#!/bin/bash
for i in ./*/
do
        cd "$i";
        gzip -d *.gz;
        cd ../;
done
```

## Remove zip files
```
#!/bin/bash
for i in ./*/
do
        cd "$i";
        rm *.zip;
        cd ../;
done
```
