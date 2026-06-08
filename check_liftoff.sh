!#/bin/bash

LIFTED=/data2/tomato/ragtag/heinz/MT1_heinz_lifted.gff3
REF_GFF=/data2/tomato/ref_genome/heinz/heinz_chr.gff3
UNMAPPED=/data2/tomato/ragtag/heinz/MT1_heinz_unmapped_features.txt


cd /data2/tomato/ragtag/heinz

# Feature type breakdown
echo "=== Feature counts ==="
grep -v "^#" MT1_heinz_lifted.gff3 | cut -f3 | sort | uniq -c | sort -rn

# Coverage distribution
echo ""
echo "=== Gene coverage ==="
grep -P "\tgene\t" MT1_heinz_lifted.gff3 | grep -oP "coverage=[0-9.]+" | cut -d= -f2 | \
    awk '{sum+=$1; n++; if($1>=0.99)h++; else if($1>=0.90)m++; else l++}
         END {printf "Mean coverage: %.4f\n  >=0.99: %d\n  0.90-0.99: %d\n  <0.90: %d\n", sum/n, h, m, l}'
