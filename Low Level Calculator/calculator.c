#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int main(int argc, char* argv[])
{
    char container[100];
    printf("Masukan persamaan:\n");
    fgets(container,100,stdin);
    // printf("%s",container);
    char newCont[100];
    int idx=0;
    int newidx=0;
    int containerLen = strlen(container);
    
    // MENGHILANGKAN SEMUA SPACE
    loop1:
    if(container[idx] != ' '){
        newCont[newidx] = container[idx];
        newidx++;
    }
    idx++;
    if(idx<containerLen){
        goto loop1;
    }

    newCont[newidx] = '\0';
    int newLen = strlen(newCont);
    newLen -=1;
    newidx = 0;
    int first = 1;
    int isAngkaLast = 0;
    char contAngka[15];
    int contIdx = 0;
    char ops = 'n';
    int res = 0;
    int tmp = 0;
    char msg[100] = "ada yang salah\n";
    int borrow,carry,tmp2 = 0,tmp3,tmp4,tmp5,tmp6,tmp7;
    int fromKali = 0;
    int sign;
    int fromBagi = 0;
    int bagi;
    int pangkat;
    int fromPangkat = 0;
    int fromPangkat2 = 0;

    angka:
    // END STATE KETIKA POINTER SUDAH BERADA DI UJUNG STRING
    // printf("%d %d %c %d\n",newLen,newidx, ops, isAngkaLast);
    if(newidx>=newLen){
        if(isAngkaLast){
            if (first && newidx>0){
                res = atof(contAngka);
            }
            contAngka[contIdx] = '\0';
            tmp = atof(contAngka);
            isAngkaLast = 0;
            if(ops == '+'){
                goto tambah; 
            }else if(ops == '-'){
                goto kurang;
            }else if(ops == '*'){
                goto initKali;
            }else if (ops == '/'){
                goto bagi;
            }else if (ops == '^'){
                goto pangkat;
            }
        }
        goto end;
    }

    // JIKA MENEMUKAN CHAR SELAIN ANGKA
    if(newCont[newidx]<'0' || newCont[newidx]>'9'){
        
        if(first && newidx>0){
            res = atof(contAngka);
        }else if (newidx>0){
            tmp = atof(contAngka);
        }

        // JIKA DITEMUKAN OPERASI DI AWAL STRING
        if(first && !isAngkaLast){
            goto error;
        }
        // JIKA DITEMUKAN OPERASI SETELAH ANGKA KE-2 DILAKUKAN PENJUMLAHAN
        else if(!first && isAngkaLast){
            isAngkaLast = 0;
            if(ops == '+'){
                goto tambah; 
            }else if(ops == '-'){
                goto kurang;
            }else if(ops == '*'){
                goto initKali;
            }else if (ops == '/'){
                goto bagi;
            }else if (ops == '^'){
                goto pangkat;
            }
        }
        // KASUS STANDAR KETIKA DITEMUKAN OPERASI ATAU KARAKTER LAIN
        else{
            contIdx = 0;
            goto verifikasi;
        }
    }else{
        contAngka[contIdx] = newCont[newidx];
        isAngkaLast = 1;
        contIdx++;
        newidx++;
        contAngka[contIdx] = '\0';
        goto angka;
    }

    verifikasi:
    isAngkaLast = 0;
    first = 0;
    // JIKA KARAKTER TERNYATA BUKAN OPERASI
    if(newCont[newidx] != '+' && newCont[newidx] != '-' && newCont[newidx] != '*' && newCont[newidx] != '/' && newCont[newidx] != '^'){
        goto error;
    }
    ops = newCont[newidx];
    newidx++;
    goto angka;

    //PENAMBAHAN
    tambah:
    carry = res & tmp;
    res = res ^ tmp;
    tmp = carry << 1;
    if(tmp != 0){
        goto tambah;
    }
    if(fromKali){
        goto kali2;
    }
    if(fromBagi){
        goto bagi4;
    }
    goto angka;

    //PENGURANGAN
    kurang:
    borrow = (~res) & tmp;
    res = res ^ tmp;
    tmp = borrow << 1;
    if(tmp != 0){
        goto kurang;
    }
    if(fromBagi){
        goto bagi3;
    }
    goto angka;

    //PERKALIAN
    initKali:
    tmp2 = 0;
    kali:
    if(tmp&1){
        tmp3 = tmp; // tmp = b
        tmp4 = res; // tmp = a
        tmp = res; // b = a
        res = tmp2; // a = res
        fromKali = 1;
        goto tambah;
        kali2:
        
        tmp2 = res;
        res = tmp4;
        tmp = tmp3;
        fromKali = 0;
    }
    res = res << 1;
    tmp = tmp >> 1;
    if(tmp>0){
        goto kali;
    }
    res = tmp2;
    if(fromPangkat){
        goto pangkat3;
    }
    if(fromPangkat2){
        goto pangkat4;
    }
    goto angka;


    //PEMBAGIAN
    bagi:

    bagi = 0;
    tmp5 = tmp;

    bagi2:
    fromBagi = 1;
    tmp = tmp5;
    goto kurang;
    
    bagi3:
    tmp3 = res;
    res = bagi;
    tmp = 1;
    goto tambah;
    
    bagi4:
    bagi = res;
    res = tmp3;
    fromBagi = 0;
    if(res>tmp){
        goto bagi2;
    }
    res = bagi;
    goto angka;


    // PANGKAT
    pangkat:
    pangkat = 1;
    pangkat2:
    tmp5 = (tmp & 1);
    if(tmp5){
        tmp7 = res;
        tmp6 = tmp;
        res = pangkat;
        tmp = tmp7;
        fromPangkat = 1;
        goto initKali;
        pangkat3:
        fromPangkat = 0;
        pangkat = res;
        res = tmp7;
        tmp = tmp6;
    }
    fromPangkat2 = 1;
    tmp6 = tmp;
    tmp = res;
    goto initKali;
    pangkat4:
    fromPangkat2 = 0;
    tmp = tmp6;
    tmp = tmp >> 1;
    if(tmp>0){
        goto pangkat2;
    }
    res = pangkat;
    goto angka;
    
    error:
    printf("%s", msg);
    goto end;

    end:
    printf("Hasil : %d",res);

    return 0; 
}