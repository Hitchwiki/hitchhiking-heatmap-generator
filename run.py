### Run this on startup
from heatchmap.gpmap import GPMap
from memory_profiler import profile

@profile
def main():
    gpmap = GPMap()

    # TODO create map from scratch if not exist yet
    gpmap.recalc_map()
    gpmap.upload()
    gpmap.cleanup()

if __name__ == "__main__":
    main()



