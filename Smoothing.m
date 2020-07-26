function Smoothing(im)
//*************************smoothing of keyword*******************************************************

[len,wid] = size(im);

	for vr1=0:len; 
		for vr2=0:wid; 
			val=0;
			for i=vr1-1:vr1+1;
				for j=vr2-1:vr2+1;
					if i!=j && i>=0 && j>=0 && i<len &&j<wid
						val=val+im1(i,j);	
                    end
					if im1(vr1,vr2)==0
						if val>=4 
						
							if vr1>0 && vr2>0 && vr1<len-1 && vr2<wid-1
							
								if (im1(vr1,vr2-1)==0 && im1(vr1,vr2+1)==0) || (im1(vr1-1,vr2)==0 && im1(vr1+1,vr2)==0)
									im(vr1,vr2)=0;
								else
									im(vr1,vr2)=1;
                                end
							else
								im(vr1,vr2)=1;
                            end
                        end
					else 
						if val<3
							im(vr1,vr2)=0;
                        end
                    end
                    j++;
                end
                i++;
            end	
            vr2++;
        end
        vr1++;
    end
	