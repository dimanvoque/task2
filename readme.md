# task1.sh
## params
+ `-n` download column ***default link***
+ `-w` number of workers ***default 2***
+ `-o` result folder ***default result***
+ `-d` data .csv ***default labelled_newscatcher_dataset.csv***

*example:* `./task1.sh -n link -w 2 -o output -d labelled_newscatcher_dataset.csv` 

# task2.sh
## params
+ `--input` input file ***default dataset.csv***
+ `--train_ratio` train ratio ***default 0.5***

*example* `./task2.sh --input dataset.csv --train_ratio 0.5`