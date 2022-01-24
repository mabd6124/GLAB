-- Create consolidated vehicle and RV systems dataset
select link_id.nvic,
	   vehicles.vcMake,
	   vehicles.vcModel,
	   vehicles.vcVariant,
	   link_id.miles_id,
	   vehicles.mRetailPrice as glass_mRetailPrice,
	   miles_vehicles.mRetailPrice as miles_mRetailPrice,
	   rv.Term,
	   rv.Kilometer,
	   rv.RVAmount,
	   rv.rvpercent as rv_system,
	   rv.dtEffective as rv_date
	   from RVDataMart.dbo.tblVehicleData as vehicles
left join RVMonthlyReporting.dbo.nvic_miles_id as link_id on vehicles.cVehicleCode = link_id.nvic
left join RVDataMart.dbo.tblVehicleData as miles_vehicles on link_id.miles_id = miles_vehicles.cVehicleCode
left join RVDataMart.dbo.ResidualValueExtract1 as rv on link_id.miles_id = rv.cVehicleCode
where link_id.nvic is not NULL
and vehicles.vcMake in ('TOYOTA','LEXUS','MAZDA')
and vehicles.dtReleaseDate >= '15 Feb 2013'
and ((rv.Term = 24 and rv.Kilometer = 40000) 
or (rv.Term = 36 and rv.Kilometer = 60000)
or (rv.Term = 36 and rv.Kilometer = 90000) 
or (rv.Term = 48 and rv.Kilometer = 80000))
and rv.inUse = 'y'