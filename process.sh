gitbranch=$(git branch |grep \* | cut -d " " -f2)
echo $gitbranch
while read p; do
  kube=$(echo "$p"| sed -e 's/^\w*:\ *//')
  label=$(echo $p | head -n1 | cut -d ":" -f1)
  loc=~/cost-experiment/pages/$gitbranch-$label.md
  echo $kube
  $kube
  echo "~~~">$loc
  kubectl get cm skupper-site -o yaml >>$loc
  echo "~~~">>$loc

  skupper status >>$loc

  skupper service status >>$loc

  echo "~~~">>$loc
  kubectl get pods >>$loc
  echo "~~~">>$loc

  skupper debug dump $loc.tar.gz


  
  

done <.vscode/skewer.txt
