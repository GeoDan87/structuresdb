create or replace function dbo.fn_iu_tbl_doitt_structures()
	returns trigger as $$	
	begin
		if(TG_OP = 'Insert') then
			insert into structuresdb.dbo.tbl_doitt_structure(row_hash)
				values(digest(concat_ws('|', new.bin, new.base_bbl, new.doitt_id, new.ground_elevation, new.height_roof, 
											 new.construction_year, new.alteration_year, new.demolition_year, new.doitt_source), 'sha256'));
			return new;
		else
			update structuresdb.dbo.tbl_doitt_structure
				set row_hash = digest(concat_ws('|', new.bin, new.base_bbl, new.doitt_id, new.ground_elevation, new.height_roof, 
												new.construction_year, new.alteration_year, new.demolition_year, new.doitt_source), 'sha256')
				where doitt_id = new.doitt_id;
			return new;
		end if;
	end;
	$$ language plpgsql;