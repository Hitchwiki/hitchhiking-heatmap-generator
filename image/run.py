### Run this on startup
from heatchmap.gpmap import GPMap
from memory_profiler import profile
import logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# to observe memory usage run with: python -m memory_profiler run.py  
@profile
def main():
    try:
        gpmap = GPMap()

        # TODO create map from scratch if not exist yet
        gpmap.recalc_map()
        gpmap.upload()
        gpmap.cleanup()

    except Exception as e:
        logging.error(f"An error occurred: {e}")
        raise Exception(f"An error occurred: {e}") from e

if __name__ == "__main__":
    main()



