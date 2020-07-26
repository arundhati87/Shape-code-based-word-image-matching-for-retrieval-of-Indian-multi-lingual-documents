function [x,y,count,missing,Mcnt,missingbb] = nextmatch(comp,bb,label,lcnt,cX,cY,dist_sarr,query_tx,QueryLen,index,count,visited,qlen,x,y,missing,Mcnt,missingbb,missingbbin,distnn)

set=0;
flag=0;
angle=0;
angle_comp=0;
qin=index+1;

while count<qlen && index<QueryLen && qin<=QueryLen  %recursive condition
      classn=setLabel(query_tx(qin));
      flag=0;
      set=0;
      
      for dist_in=1:6
          minDist=dist_sarr(dist_in,1);
          minCor(1)=dist_sarr(dist_in,2);
          minCor(2)=dist_sarr(dist_in,3);
          
          if (minCor(2) == classn)
              x_plot=[cX(comp),cX(minCor(1))];
              y_plot=[cY(comp),cY(minCor(1))];
              %plot(x_plot,y_plot,'--r','LineWidth',2);
              va=[cX(comp),cY(comp)]-[cX(minCor(1)),cY(minCor(1))]; 
              vb=[cX(comp),cY(comp)]-[cX(minCor(1)),cY(comp)];
              a1 = mod(atan2( det([va;vb;]) , dot(va,vb) ), 2*pi );
              angleout = abs((a1>pi/2)*pi-a1);
              angle = angleout*180/pi;
              %%relative direction of two nearest points
              if cX(minCor(1))< cX(comp)
                  
                  if cY(minCor(1))< cY(comp)
                     dir=1;
                  else
                      dir=4;
                  end
              elseif cY(minCor(1))< cY(comp)
                  dir=2;
              else
                  dir=3;
              end
 
              if angle>90
                  angle=180-angle;
              end
              
              %%distance between two nearest points
              dist1=minDist;
              distn=distnn;
              distn1=dist1/(qin-index);
              spacing = abs(distn1-distn);
              
              %%relative height of two nearest points
              ht1=bb(minCor(1),4);
              ht2=bb(comp,4);
              htflag=0;
              if ht1>ht2 && 2*ht2>ht1
                 htflag=1; 
              elseif ht2>ht1 && 2*ht1>ht2
                  htflag=1;
              elseif ht2==ht1
                  htflag=1;
              end
              
              bbin=0;
              
              if (count==1 || (abs(angle_comp-angle)<30 && spacing<20 && abs(dirnn-dir)~=2)) && htflag==1
                 plot(x_plot,y_plot,'--b','LineWidth',2); 
                 angle_comp = angle;
                 distnn=distn1;
                 dirnn=dir;
                 flag=1;
                 count=count+1;
                 x(count)=cX(minCor(1));
                 y(count)=cY(minCor(1));
                 in=minCor(1);
                 bbin=minCor(1);
                 vlen=length(visited);
                 visited(vlen+1)=in;
                 
                 for lqin=index+1:qin-1
                     Mcnt=Mcnt+1;
                     missingbbin=missingbbin+1;
                     missing(Mcnt)=missingbbin;
                     Mcnt=Mcnt+1;
                     missing(Mcnt)=lqin;
                     
                     if lqin == index+1
                         
                        if bb(comp,1)< bb(bbin,1)
                           v1=bb(comp,1);
                           v3=bb(bbin,1)-bb(comp,1)+bb(comp,3)+bb(bbin,3);
                        else
                           v1=bb(bbin,1);
                           v3=bb(comp,1)-bb(bbin,1)+bb(comp,3)+bb(bbin,3);
                        end
                        
                        if bb(comp,2)< bb(bbin,2)
                           v2=bb(comp,2);
                           v4=bb(bbin,2)-bb(comp,2)+bb(comp,4)+bb(bbin,4);
                        else
                           v2=bb(bbin,2);
                           v4=bb(comp,2)-bb(bbin,2)+bb(comp,4)+bb(bbin,4);
                        end
                        
                        missingbb(missingbbin,1)=v1;
                        missingbb(missingbbin,2)=v2;
                        missingbb(missingbbin,3)=v3;
                        missingbb(missingbbin,4)=v4;
                     end
                     
                 end
                  
                 [dist_sarr] = NearestNeighbour(label,lcnt,cX,cY,in,visited);
                 comp=in;               
                 index=qin;
                 qin=index+1;
                 set=1;
                 break; 
              end
          end
      end
    if set ~=1
       qin=qin+1;
       set=0;
    end
    if flag==0 && qin>QueryLen
        index = qin;
        
        if count>=QueryLen/2 
            
            for lqin=index+1:QueryLen
                 Mcnt=Mcnt+1;
                 missingbbin=missingbbin+1;
                 missing(Mcnt)=missingbbin;
                 Mcnt=Mcnt+1;
                 missing(Mcnt)=lqin;
                 v1=bb(comp,1)+(lqin-index)*bb(comp,3);
                 v2=bb(comp,2)-2*bb(comp,4);
                 v3=5*bb(comp,3)+distnn*(lqin-index-1);
                 v4=5*bb(comp,4);
                 missingbb(missingbbin,1)=v1;
                 missingbb(missingbbin,2)=v2;
                 missingbb(missingbbin,3)=v3;
                 missingbb(missingbbin,4)=v4;
            end
            
        end
        
    end
    
end