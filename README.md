README: Image Downloader
=================================================

Image Downloader is a command-line tool that allows you to download a list of images from a plain text file. It is designed to fulfill the requirements set by "The Big Picture Corp" for downloading images from URLs and storing them on the local hard drive.

📋 Table of contents
-----------------

* [Implementation Details](#implementation-details)
* [Installation](#installation)
* [Usage](#usage)
* [Contributing](#contributing)
* [Authors](#authors)

🤓 Implementation Details
---------------
Here's a quick explanation of why this approach was chosen:

1. **Modular Structure**: The code is organized into modules (`Images::Downloader` and `Images::Validator`), promoting modularity and separation of concerns. This structure allows for easy maintenance, extensibility, and reuse of code.

2. **Error Handling**: The code incorporates error handling by raising custom exceptions (`Errors::FILE_NOT_FOUND`, `Errors::FILE_EMPTY`, `Errors::URL_INVALID_CONTENT_TYPE`). This ensures that errors are properly handled and appropriate error messages are provided to users.

3. **File Validation**: The `check_file` method validates the existence and non-empty nature of the input file. This ensures that the code can handle different file scenarios and provides meaningful feedback when the file is invalid.

4. **URL Validation**: The `check_url` method validates the URL and its content type. It checks if the URL is accessible and verifies if the content type is an image. This validation helps filter out invalid URLs and ensures that only images are downloaded.

5. **Batch Processing**: The implementation supports batch processing of image URLs from the plain text file. It iterates through each URL, validates it, and downloads the valid images. The code maintains a count of the downloaded images and collects any encountered errors for reporting purposes.

6. **Logging and Reporting**: The implementation incorporates logging using `ActiveSupport::Logger`. It logs the start and end time of the task, the number of images downloaded, and any encountered errors. This facilitates tracking and analysis of the image download process.

7. **Command-Line Interface**: The solution can be executed through a command-line interface by utilizing the provided Rake task `images:download_batch`. This allows users to invoke the image download functionality easily and efficiently.

8. **Testing**: The implementation includes RSpec tests to verify the behavior of the `Images::Downloader` and `Images::Validator`. The tests cover different scenarios such as file validation, URL validation, error handling, and successful image downloads.

9. **Docker**: Docker provides an isolated development environment that ensures reproducibility and simplifies dependency management.

By following this implementation approach, the code provides a structured, maintainable, and extensible solution for downloading images from a plain text file.


💻 Installation
------------

### Prerequisites

* Docker version 24.0.2
* Docker Compose version v2.18.1


### Instructions

1. Clone repo
2. Fill out the .env file based on the .env.sample provided
3. Run `sudo docker compose build`
 

🖱️Usage
-----

`docker compose run web rake images:download_batch\["file/path"\]`

✅ Tests Suite
------------
`sudo docker compose run web rspec spec`

🙌 Contributing
------------

1. Follow the steps in [Installation](#installation)
2. Create a new branch
2. Create a new PR

Authors
---------------------------

[Daniela Patiño](https://about.me/dani.pb)
