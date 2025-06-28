### Run this on startup
from heatchmap.gpmap import GPMap


gpmap = GPMap()

# TODO create map from scratch if not exist yet
gpmap.recalc_map()
gpmap.upload()
gpmap.cleanup()



