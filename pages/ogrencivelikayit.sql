ALTER procedure [dbo].[ogrencivelikayit](@tc char(11),@adi varchar(50), @soyadi varchar(50), @ogrfoto varchar(20),@calismaid int,@caddeid int,@diskapino varchar(5),@ickapino varchar(5),@adres varchar(250),@koordinatx char(10),@koordinaty char(10),@servishid int, @vtc char(11),@vadi varchar(50), @vsoyadi varchar(50),@telefon char(10),@mail varchar(100),@velifoto varchar(20),@parola char(32), @ogrout int out, @vout int out, @ogrvar bit out, @velivar bit out)
as
declare @ogrid int
declare @veliID int
set @ogrvar=0
set @velivar=0
select @ogrid=OgrenciId from Ogrenci where KimlikNo=@tc
IF(@ogrid is not null) 

begin
	set @ogrout=@ogrid
	set  @ogrvar=1
end
else
begin
	insert into Ogrenci(KimlikNo,Ad,Soyad,Fotograf,OkulCalismaId,CaddeId,DisKapiNo,IcKapiNo,AcikAdres,KoordinatX,KoordinatY,ServisHareketId) values (@tc,@adi,@soyadi,@tc+@ogrfoto,@calismaid,@caddeid,@diskapino,@ickapino,@adres,@koordinatx,@koordinaty,@servishid)
	SET @ogrid = SCOPE_IDENTITY()
	set @ogrout=@ogrid
	set @ogrvar=0

	select @veliID=veliId from veli where KimlikNo=@vtc
	IF (@veliID is not null)
	begin
		set @vout=@veliID
		set  @velivar=1
	end
	else
	begin
		insert into veli(KimlikNo,Ad,Soyad,Telefon,Email,Fotograf,Parola) values (@vtc,@vadi,@vsoyadi,@telefon,@mail,@vtc+@velifoto,@parola)
		set @veliID=SCOPE_IDENTITY()
		insert into OgrenciVeli(OgrenciId,VeliId) values (@ogrid,@veliID)
		set @vout=@veliID
		set @velivar=0
	end

end
return @ogrout + @vout + @ogrvar + @velivar
