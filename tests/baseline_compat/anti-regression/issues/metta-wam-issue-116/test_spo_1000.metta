!(import! &hald1000 hald_spo_1000)
!(assertEqualToResult (match &hald1000 (Doxorubicin $p $o) (Doxorubicin $p $o)) 
     ((Doxorubicin stratify Liposarcoma) (Doxorubicin associated MIR375)))
