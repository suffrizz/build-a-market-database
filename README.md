# Processing databases about market in humbang hasudungan

#### 1. Display merchants coming from addresses containing the letter “o”.
``` Select *
From pedagang
Where asal_pedagang 
Like '%o%';
```
#### Result :
![image](https://github.com/suffrizz/build-a-market-database/assets/128014102/11ab4702-f4d8-4ea9-a273-dfa4400291c0)

---

#### 2. Displays the same item list name, from the merchants table .
``` Select *
From pedagang
Group by daftar_barang
Having count(daftar_barang) > 1;
```
#### Result : 
![image](https://github.com/suffrizz/build-a-market-database/assets/128014102/8f15eebc-9af4-4c40-8de9-622bfe81df87)

---

#### 3. Displays merchants who are paying the biggest levy fee .
``` Select pedagang.id_pedagang, pedagang.nama_pedagang, lapak.jenis_lapak, lapak.harga_retribusi, lapak.tipe_lapak
From pedagang
Inner join lapak
On pedagang.id_pedagang = lapak.id_pedagang
Order by harga_retribusi desc;
 ```
 #### Result : 
 ![image](https://github.com/suffrizz/build-a-market-database/assets/128014102/87ec986f-ee59-4dc9-ba0d-578293f468b6)
 
 ---
 
 #### 4. Displays traders who pay fees below the average fee fees in the market
 ``` Select pedagang.id_pedagang, pedagang.nama_pedagang, lapak.jenis_lapak, lapak.harga_retribusi
From pedagang
Inner join lapak
On pedagang.id_pedagang = lapak.id_pedagang
Where harga_retribusi < 47000;
```
#### Result : 
![image](https://github.com/suffrizz/build-a-market-database/assets/128014102/f5a29624-ab9b-423d-afa5-f7d75a193e34)

---

#### 5. Displays a list of officers (retributors) who collect retribution for more than 1 different market.
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

---

#### 6. Displays traders who have more than 1 stall to trade with.
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

---

#### 7. Create a stored procedure to add data to the trader table
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

---

#### 8. Create a store procedure to display traders by type stalls/buildings where each sells
```delimiter $
Create procedure lapak_pedagang()
Begin
	Select pedagang.id_pedagang, pedagang.nama_pedagang, lapak.jenis_lapak
    From pedagang
    Inner join lapak
    On pedagang.id_pedagang = lapak.id_pedagang;
End $
delimiter ;

Call lapak_pedagang;
```
#### Result :
![image](https://github.com/suffrizz/build-a-market-database/assets/128014102/839dd523-2f43-4ebd-b8b5-7f03ee22a336)

---

#### 9. Create a store function to make a price discount of 15% of the fee for type III and IV kiosk traders.
``` delimiter $
Create function discount(harga_retribusi decimal(15, 3), discount decimal(15, 2))
Returns decimal(15, 2)
Deterministic
Begin
	Declare price decimal(15, 2);
	Declare disc_price decimal(14, 2);
	Set disc_price = harga_retribusi * (discount / 100);
	Set price = harga_retribusi - disc_price;
	Return price;
End $
delimiter ;

Select id_pedagang, tipe_lapak, jenis_lapak, discount(harga_retribusi, 15) as price
From lapak
Where tipe_lapak between 'Type III' and 'Type IV' and jenis_lapak = 'Kios'
```
#### Result : 
![image](https://github.com/suffrizz/build-a-market-database/assets/128014102/8da4f75c-3760-478c-9ad4-cd5021183d15)

---

#### 10. Create a store function to increase the levy fee by 10% for Basic traders with Type I.
```
delimiter $
Create function add_price(harga_retribusi decimal (10,3) , add_price decimal(10,2))
returns decimal (10,2)
Deterministic
Begin
	Declare price decimal(10, 2);
	Declare up_price decimal(14, 2);
	Set up_price = harga_retribusi * (add_price / 100);
	Set price = harga_retribusi + up_price;
	Return price;
End $
delimiter ;

Select id_pedagang, tipe_lapak, jenis_lapak, add_price(harga_retribusi,10) as price
From lapak
Where tipe_lapak = 'Type I' and jenis_lapak = 'Dasaran' 
```

#### Result : 
![image](https://github.com/suffrizz/build-a-market-database/assets/128014102/946801ea-3e16-4e97-aba8-0226f25bb837)





 

