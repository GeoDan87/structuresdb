create trigger trg_iu_tbl_doitt_structures
	after insert or update
	on structuresdb.dbo.tbl_doitt_structures
	for each row
	execute procedure dbo.fn_iu_tbl_doitt_structures();