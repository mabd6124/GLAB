--Disposals data
select * from RVDataMart.dbo.tblDisposalsConsolidated
where DataSource = 'E' 
and dtSaleDate >= '1 Jan 2021'
and vcMake in ('TOYOTA','LEXUS')