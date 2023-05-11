# Processing databases about market in humbang hasudungan

### Display merchants coming from addresses containing the letter “o”.
``` Select *
From pedagang
Where asal_pedagang 
Like '%o%';
```
#### Result :
![image](https://github.com/suffrizz/build-a-market-database/assets/128014102/11ab4702-f4d8-4ea9-a273-dfa4400291c0)
##
### Displays the same item list name, from the merchants table .
``` Select *
From pedagang
Group by daftar_barang
Having count(daftar_barang) > 1;
```
#### Result : 
![image](https://github.com/suffrizz/build-a-market-database/assets/128014102/8f15eebc-9af4-4c40-8de9-622bfe81df87)

### Displays merchants who are paying the biggest levy fee .
``` Select pedagang.id_pedagang, pedagang.nama_pedagang, lapak.jenis_lapak, lapak.harga_retribusi, lapak.tipe_lapak
From pedagang
Inner join lapak
On pedagang.id_pedagang = lapak.id_pedagang
Order by harga_retribusi desc;
 ```
 #### Result : 
 ![image](https://github.com/suffrizz/build-a-market-database/assets/128014102/87ec986f-ee59-4dc9-ba0d-578293f468b6)
 
 ### Displays traders who pay fees below the average fee fees in the market
 ``` Select pedagang.id_pedagang, pedagang.nama_pedagang, lapak.jenis_lapak, lapak.harga_retribusi
From pedagang
Inner join lapak
On pedagang.id_pedagang = lapak.id_pedagang
Where harga_retribusi < 47000;
```
#### Result : 
![image](https://github.com/suffrizz/build-a-market-database/assets/128014102/f5a29624-ab9b-423d-afa5-f7d75a193e34)

### Displays a list of officers (retributors) who collect retribution for more than 1 different market.
```Select *
From petugas
Where id_petugas
In(
	Select id_petugas
	From pasar_petugas
    Group by id_petugas
	Having count(id_petugas) > 1
) 
Order by id_petugas;
```
#### Result : 
![image](https://github.com/suffrizz/build-a-market-database/assets/128014102/51eeafd5-fc34-4d3d-ad11-364cc8b3ab8a)

### Displays traders who have more than 1 stall to trade with.
```Select *
From pedagang
Where id_pedagang 
In(
	Select id_pedagang
	From lapak
    Group by id_pedagang
    Having count(id_pedagang) > 1
)
Order by id_pedagang;
```
#### Result : 
![image](https://github.com/suffrizz/build-a-market-database/assets/128014102/88741cda-e2ba-4a8d-b4bd-b8f28472a4e3)

### Create a stored procedure to add data to the trader table
```delimiter $
Create procedure add_pedagang(
	id_pedagang varchar(20),
    nama_pedagang varchar(20),
    asal_pedagang varchar(20),
    no_handphone int,
    daftar_barang varchar(20),
    id_petugas varchar(20)
)
Begin
	Insert into pedagang values(id_pedagang, nama_pedagang, asal_pedagang, no_handphone, daftar_barang, id_petugas);
End $
delimiter ;

Call add_pedagang('PDG_7','Natanio','Onan Ganjang','08137654','Pakaian','PTG_004');

Select *
From pedagang;
```
#### Result : 
![image](https://github.com/suffrizz/build-a-market-database/assets/128014102/fb6e349d-909f-4ff4-ab3a-e0d51bbf2f53)




 

