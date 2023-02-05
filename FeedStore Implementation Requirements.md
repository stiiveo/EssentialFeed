
# FeedStore Implementation Requirements

- Retrieve
	- Empty cache
	- Non-empty cache returns data
	- Non-empty cache twice returns same data (no side-effects)
	- Error (if applicable, e.g., invalid data)
	
- Insert
	- To empty cache stores data
	- To non-empty cache overrides previous data with new data
	- Error (if applicable, e.g., no write permission)
	
- Delete
	- Empty cache does nothing (cache stays empty and does not fail)
	- Non-empty cache leaves cache empty
	- Error (if applicable, e.g., no delete permission)

**Side-effects must run serially to avoid race-conditions**
