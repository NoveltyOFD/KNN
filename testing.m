a = 'Data Train.xlsx'
b = 'Data Test.xlsx' 
dataTrain = xlsread(a);
dataTest = xlsread(b);


maksAkurasi =0;
Kterbaik = 1;
for kfold = 4:100
    if (mod(size(dataTrain,1),kfold)==0)
        for K = 1:100
            if (mod(K,2) ==1)
                [ ratarataakurasi ] = KNNtrain( kfold,K,dataTrain,dataTest );
                if (ratarataakurasi > maksAkurasi)
                    maksAkurasi = ratarataakurasi;
                    Kterbaik = K;
                    foldterbaik = kfold;
                end
            end
        end
    end
end


for i = 1:size(dataTest,1)
    hasil = [];
    angka0 = 0;
    angka1 = 0;
    for j = 1:size(dataTrain,1)
        like = (dataTrain(j,1)-dataTest(i,1))^2;
        provokasi = (dataTrain(j,2)-dataTest(i,2))^2;
        komentar = (dataTrain(j,3)-dataTest(i,3))^2;
        emosi = (dataTrain(j,4)-dataTest(i,4))^2;
        total = (like+provokasi+komentar+emosi)^0.5;
        hasil(j,1)= total;
        hasil(j,2)= dataTrain(j,5);
    end
    hasil = sortrows(hasil,1);
    for  l =1:Kterbaik
        if (hasil(l,2)==0)
            angka0 = angka0 +1;
        else
            angka1 = angka1 +1;
        end
    end
    if (angka0 > angka1)
        dataTest(i,5) = 0;
    else 
        dataTest(i,5) = 1;
    end
end

xlswrite('Hasilbaru.xlsx',dataTest)