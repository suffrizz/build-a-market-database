create database retribusi_db;

use retribusi_db;

create table bendahara
(
	id_bendahara varchar(20),
	nama_bendahara varchar(20),
    primary key(id_bendahara)
);

create table pasar
(
	id_pasar varchar(20),
    nama_pasar varchar(50),
    alamat_pasar varchar(20),
    id_petugas varchar(20),
    primary key(id_pasar),
    foreign key(id_petugas) references petugas(id_petugas)
);

create table petugas
(
	id_petugas varchar(20),
    nama_petugas varchar(20),
    lokasi_petugas varchar(20),
    id_bendahara varchar(20),
    primary key(id_petugas),
    foreign key(id_bendahara) references bendahara(id_bendahara)
);

create table pasar_petugas
(
	id_pasar varchar(20),
    id_petugas varchar(20),
    primary key(id_pasar),
    foreign key(id_petugas) references petugas(id_petugas)
);

create table pedagang
(
	id_pedagang varchar(20),
    nama_pedagang varchar(20),
    asal_pedagang varchar(20),
    no_handphone int,
    daftar_barang varchar(20),
    id_petugas varchar(20),
    primary key(id_pedagang),
    foreign key(id_petugas) references petugas(id_petugas)
);

create table lapak
(
	nama_lapak varchar(20),
    tipe_lapak varchar(20),
    jenis_lapak varchar(20),
    ukuran_lapak varchar(20),
    harga_retribusi int,
    id_pedagang varchar(20),
    primary key(nama_lapak),
    foreign key(id_pedagang) references pedagang(id_pedagang)
);

-- Data Dummy Bendahara
insert into bendahara values('BND_01','Johan');
insert into bendahara values('BND_02','Rifki');
insert into bendahara values('BND_03','Rifan');
insert into bendahara values('BND_04','Sofian');
insert into bendahara values('BND_05','Faisal');

-- Data Dummy Petugas
insert into petugas values('PTG_001','Zul','Matiti','BND_01');
insert into petugas values('PTG_002','Filipus','Doloksanggul','BND_02');
insert into petugas values('PTG_003','Paulus','Baktiraja','BND_03');
insert into petugas values('PTG_004','Sulpisius','Pakkat','BND_04');
insert into petugas values('PTG_005','Fajar','Sihite','BND_05');

-- Data Dummy Pasar
insert into pasar values('PSR_1','Toko LIA','Doloksanggul','PTG_001');
insert into pasar values('PSR_2','Pasar Tradisional Doloksanggul','Doloksanggul','PTG_002');
insert into pasar values('PSR_3','Pasar Muara','Muara','PTG_003');
insert into pasar values('PSR_4','Onan Bakkara','Bakkara','PTG_004');
insert into pasar values('PSR_5','Jojo Rujak','Lintongnihuta','PTG_005');
insert into pasar values('PSR_6','Pasar Parlilitan','Parlilitan','PTG_003');

-- Data Dummy Pasar_Petugas
insert into pasar_petugas values('PSR_1','PTG_001');
insert into pasar_petugas values('PSR_2','PTG_002');
insert into pasar_petugas values('PSR_3','PTG_003');
insert into pasar_petugas values('PSR_4','PTG_004');
insert into pasar_petugas values('PSR_5','PTG_005');
insert into pasar_petugas values('PSR_6','PTG_003');
insert into pasar_petugas values('PSR_7','PTG_004');

-- Data Dummy Pedagang
insert into pedagang values('PDG_1','Vivel','Sijama Polang','08138180','Alat Elektronik','PTG_001');
insert into pedagang values('PDG_2','Joan','Pollung','08124238','Sembako','PTG_002');
insert into pedagang values('PDG_3','Luhut','Paranginan','08524384','Ikan','PTG_003');
insert into pedagang values('PDG_4','Surbakti','Sijama Polang','08137652','Sembako','PTG_004');
insert into pedagang values('PDG_5','Jonathan','Baktiraja','08124289','Rujak','PTG_005');
insert into pedagang values('PDG_6','Yosua','Bonan Dolok','08528670','Ikan','PTG_003');

-- Data Dummy Lapak
insert into lapak values('1A','Type I','Dasaran','2*2 m','4000','PDG_3');
insert into lapak values('2B','Type I','Kios','48 m^2','100000','PDG_1');
insert into lapak values('3C','Type II','Los','4 m^2','96000','PDG_2');
insert into lapak values('4D','Type II','Kios','36 m^2','100000','PDG_3');
insert into lapak values('5E','Type III','Los','2 m^2','96000','PDG_4');
insert into lapak values('6F','Type III','Dasaran','2*4 m','3000','PDG_5');
insert into lapak values('7G','Type III','Kios','24 m^2','60000','PDG_6');
insert into lapak values('8H','Type IV','Los','4 m^2','48000','PDG_1');
insert into lapak values('9I','Type IV','Dasaran','2*6 m','4000','PDG_2');
insert into lapak values('10J','Type IV','Kios','12 m^2','40000','PDG_4');
insert into lapak values('11K','Type IV','Los','2 m^2','48000','PDG_5');

-- Query No 1A(Tabel)
Select *
From pedagang
Where asal_pedagang 
Like '%o%';

-- Query No 1B(Table)
Select *
From pedagang
Group by daftar_barang
Having count(daftar_barang) > 1;

-- Query No 2A(Join Table)
Select pedagang.id_pedagang, pedagang.nama_pedagang, lapak.jenis_lapak, lapak.harga_retribusi, lapak.tipe_lapak
From pedagang
Inner join lapak
On pedagang.id_pedagang = lapak.id_pedagang
Order by harga_retribusi desc;

-- Query No 2B(Join Table)
Select pedagang.id_pedagang, pedagang.nama_pedagang, lapak.jenis_lapak, lapak.harga_retribusi
From pedagang
Inner join lapak
On pedagang.id_pedagang = lapak.id_pedagang
Where harga_retribusi < 47000;

-- Query No 3A(Subquery)
Select *
From petugas
Where id_petugas
In(
	Select id_petugas
	From pasar_petugas
    Group by id_petugas
	Having count(id_petugas) > 1
) 
Order by id_petugas;

-- Query No 3B(Subquery)
Select *
From pedagang
Where id_pedagang 
In(
	Select id_pedagang
	From lapak
    Group by id_pedagang
    Having count(id_pedagang) > 1
)
Order by id_pedagang;

-- Query No 4A(Store Procedure)
delimiter $
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

-- Query No 4B(Store Procedure)
delimiter $
Create procedure lapak_pedagang()
Begin
	Select pedagang.id_pedagang, pedagang.nama_pedagang, lapak.jenis_lapak
    From pedagang
    Inner join lapak
    On pedagang.id_pedagang = lapak.id_pedagang;
End $
delimiter ;

Call lapak_pedagang;

-- Query No 5A(Store Function)
delimiter $
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

-- Query No 5B(Store Function)
delimiter $
Create function add_price(harga_retribusi decimal(10, 3), add_price decimal(10, 2))
Returns decimal(10, 2)
Deterministic
Begin
	Declare price decimal(10, 2);
    Declare up_price decimal(14, 2);
    Set up_price = harga_retribusi * (add_price / 100);
    Set price = harga_retribusi + up_price;
    Return price;
End $
delimiter ;

Select id_pedagang, tipe_lapak, jenis_lapak, add_price(harga_retribusi, 10) as price
From lapak
Where tipe_lapak = 'Type I' and jenis_lapak = 'Dasaran'