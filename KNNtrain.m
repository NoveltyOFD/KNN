function [ ratarataakurasi ] = KNNtrain( kfold,K,dataTrain,dataTest )
    akurasi =0;
    for i = 1:kfold
        disp(i)
        totalbenar = 0;
        if (i==1)
            x = size(dataTrain,1)/kfold;
            for j = 1:x
                hasil = [];
                angka0 = 0;
                angka1 = 0;
                count = 0;
                for l = (x+1):size(dataTrain,1)
                    count = count+1;
                    like = (dataTrain(j,1)-dataTrain(l,1))^2;
                    provokasi = (dataTrain(j,2)-dataTrain(l,2))^2;
                    komentar = (dataTrain(j,3)-dataTrain(l,3))^2;
                    emosi = (dataTrain(j,4)-dataTrain(l,4))^2;
                    total = (like+provokasi+komentar+emosi)^0.5;
                    hasil(count,1)= total;
                    hasil(count,2)= dataTrain(l,5);
                end
                hasil = sortrows(hasil,1);
                for  l =1:K
                    if (hasil(l,2)==0)
                        angka0 = angka0 +1;
                    else
                        angka1 = angka1 +1;
                    end
                end
                if (angka0 > angka1)
                    kesimpulan = 0;
                else
                    kesimpulan = 1;
                end
                if (kesimpulan == dataTrain(j,5))
                    totalbenar = totalbenar+1;
                end
            end
            akurasi= akurasi + (totalbenar/x)*100;
        elseif (i==kfold)
            x = (size(dataTrain,1)/kfold)*(kfold-1);
            y = (size(dataTrain,1)/kfold);
            for j = (x+1):size(dataTrain,1)
                hasil = [];
                angka0 = 0;
                angka1 = 0;
                count = 0;
                for l = 1:x
                    count = count + 1;
                    like = (dataTrain(j,1)-dataTrain(l,1))^2;
                    provokasi = (dataTrain(j,2)-dataTrain(l,2))^2;
                    komentar = (dataTrain(j,3)-dataTrain(l,3))^2;
                    emosi = (dataTrain(j,4)-dataTrain(l,4))^2;
                    total = (like+provokasi+komentar+emosi)^0.5;
                    hasil(count,1)= total;
                    hasil(count,2)= dataTrain(l,5);
                end
                hasil = sortrows(hasil,1);
                for  l =1:K
                    if (hasil(l,2)==0)
                        angka0 = angka0 +1;
                    else
                        angka1 = angka1 +1;
                    end
                end
                if (angka0 > angka1)
                    kesimpulan = 0;
                else
                    kesimpulan = 1;
                end
                if (kesimpulan == dataTrain(j,5))
                    totalbenar = totalbenar+1;
                end
            end
            akurasi= akurasi + (totalbenar/y)*100;    
        else
            batas1 = (size(dataTrain,1)/kfold)*(i-1);
            batas2 = (size(dataTrain,1)/kfold)*i;
            for j = (batas1+1):batas2
                hasil = [];
                angka0 = 0;
                angka1 = 0;
                count =0;
                for l = 1:batas1
                    count = count +1;
                    like = (dataTrain(j,1)-dataTrain(l,1))^2;
                    provokasi = (dataTrain(j,2)-dataTrain(l,2))^2;
                    komentar = (dataTrain(j,3)-dataTrain(l,3))^2;
                    emosi = (dataTrain(j,4)-dataTrain(l,4))^2;
                    total = (like+provokasi+komentar+emosi)^0.5;
                    hasil(count,1)= total;
                    hasil(count,2)= dataTrain(l,5);
                end
                for l = (batas2+1):size(dataTrain,1)
                    count = count+1;
                    like = (dataTrain(j,1)-dataTrain(l,1))^2;
                    provokasi = (dataTrain(j,2)-dataTrain(l,2))^2;
                    komentar = (dataTrain(j,3)-dataTrain(l,3))^2;
                    emosi = (dataTrain(j,4)-dataTrain(l,4))^2;
                    total = (like+provokasi+komentar+emosi)^0.5;
                    hasil(count,1)= total;
                    hasil(count,2)= dataTrain(l,5);
                end
                hasil = sortrows(hasil,1);
                for  l =1:K
                    if (hasil(l,2)==0)
                        angka0 = angka0 +1;
                    else
                        angka1 = angka1 +1;
                    end
                end
                if (angka0 > angka1)
                    kesimpulan = 0;
                else
                    kesimpulan = 1;
                end
                if (kesimpulan == dataTrain(j,5))
                    totalbenar = totalbenar+1;
                end
            end
            akurasi= akurasi + (totalbenar/x)*100;    
        end
    end
    ratarataakurasi = akurasi/kfold;
end

