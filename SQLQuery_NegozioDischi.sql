			--ALTER TABLE Album
--ADD UNIQUE (Titolo,AnnoUscita,CasaDiscografica,Genere,SupportoDistribuzione);

--	Scrivere una query che restituisca i titoli degli album di Franco Battiato;
SELECT a.Titolo [Titoli Album Franco Battiato]
FROM Album a
INNER JOIN Band b
ON a.IDBand=b.ID
WHERE b.Nome='Franco Battiato'

--	Selezionare tutti gli album editi dalla casa editrice nell’anno specificato;
SELECT *
FROM Album
WHERE CasaDiscografica='Bla' AND YEAR(AnnoUscita)=1983

--	Scrivere una query che restituisca tutti i titoli delle canzoni dei U2 appartenenti ad album pubblicati prima del 1990;

SELECT Brano.Titolo
FROM AlbumBrano ab
INNER JOIN(
	SELECT b.ID as [BandID], AnnoUscita
	FROM Band b
	INNER JOIN Album a
	ON a.IDBand = b.ID
	WHERE YEAR(AnnoUscita)<'1990' AND Nome='U2') tb
ON ab.IDAlbum = tb.BandID
INNER JOIN Brano
ON ab.IDBrano=Brano.ID

--	Individuare tutti gli album in cui è contenuta la canzone “Imagine”;
SELECT a.Titolo as [Titolo Album]
FROM Album a
INNER JOIN AlbumBrano ab
ON a.ID = ab.IDAlbum
INNER JOIN Brano b
ON b.ID = ab.IDBrano
WHERE b.Titolo = 'Imagine'
--WHERE CONTAINS('Imagine' , b.Titolo) = 1

--	Restituire il numero totale di canzoni eseguite dai Pooh;
SELECT COUNT(*) as [Numero Brani dei Pooh]
FROM AlbumBrano ab
INNER JOIN Album a
ON ab.IDAlbum = a.ID
INNER JOIN Band b
ON b.ID = a.IDBand
WHERE b.Nome='Pooh'

--	Contare per ogni album, la somma dei minuti dei brani contenuti
SELECT SUM(Durata) AS [Minuti Totali Album], a.Titolo
FROM Brano b
INNER JOIN AlbumBrano ab
ON b.ID = ab.IDBrano
INNER JOIN Album a
ON a.ID = ab.IDAlbum
GROUP BY a.Titolo
