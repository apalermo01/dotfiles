import logging
import os
from typing import Dict
from . import allowed_elements
import shutil

logger = logging.getLogger(__name__)


def validate_config(config: Dict) -> bool:
    for key in allowed_elements:

        num_elements_of_category = sum(
            1 for i in allowed_elements[key] if i in config.keys())
        if num_elements_of_category > 1:
            print(f"\x1b[31mMultiple elements found for {
                  key}. Config must have one or none of {allowed_elements[key]}")

            return False
    return True


def default_parser(default_config_path: str,
                   destination_config_path: str,
                   theme_config_path: str,
                   theme_name: str,):

    logger.info(f"{theme_name} is running the default parser")

    write_source_to_file(default_config_path, destination_config_path)

    if os.path.exists(theme_config_path) \
            and not os.path.samefile(theme_config_path, default_config_path):
        append_source_to_file(theme_config_path, destination_config_path)


def write_source_to_file(src: str, dst: str):

    with open(src, "r") as f_src, open(dst, "w") as f_dst:
        for line in f_src.readlines():
            f_dst.write(line)

    logger.info(f"wrote {src} to {dst}")


def append_source_to_file(src: str, dst: str):

    if not os.path.exists(src):
        return

    with open(src, "r") as f_src, open(dst, "a") as f_dst:
        for line in f_src.readlines():
            f_dst.write(line)

    logger.info(f"appended {src} to {dst}")


def append_text(src: str, text: str):

    with open(src, "a") as f:
        f.write(text)


def copy_all_files(src_folder: str, dest_folder: str):

    for root, dirs, files in os.walk():
        rel_path = os.path.relpath(root, src_folder)
        dest_subfolder = os.path.join(dest_folder, rel_path)

        if not os.path.exists(dest_subfolder):
            os.makedirs(dest_subfolder)

        for file in files:
            src_file = os.path.join(root, file)
            dest_file = os.path.join(dest_subfolder, file)

            shutil.copy2(src_file, dest_file)
            logger.info(f"copied {src_file} to {dest_file}")
