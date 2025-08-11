👟 Shoe Store - My first flutter project
A sleek and intuitive mobile application built with Flutter, designed to offer a seamless shoe shopping experience! Browse a wide range of footwear, filter by brand, and find exactly what you're looking for with our smart search functionality.

✨ Features
Dynamic Product Listing: Explore a diverse collection of shoes with detailed information for each.

Intuitive Filtering: Easily narrow down your choices by brand using dedicated filter chips.

Intelligent Search (Keyword & Phrase Match): Our custom search algorithm provides highly relevant results by prioritizing exact phrase matches and dynamically scoring partial word matches.

Responsive UI: Enjoy a consistent and visually appealing experience on various screen sizes and devices.

Product Details View: Tap on any shoe to see more details, including available sizes and pricing.

🚀 Getting Started
Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

Prerequisites
Make sure you have the Flutter SDK installed on your machine. If not, follow the official Flutter installation guide:
Flutter Installation Guide

Installation
Clone the Repository:

git clone https://github.com/your-username/flutter_shoe_store.git
cd flutter_shoe_store

(Remember to replace your-username with your actual GitHub username!)

Get Dependencies:

flutter pub get

Run the App:

flutter run

This will launch the app on your connected device or emulator.

🔍 Search Algorithm Highlights
Our search functionality is designed for a highly intuitive user experience:

Normalization: All search queries and product titles are normalized (converted to lowercase, punctuation removed, extra spaces trimmed) to ensure consistent matching.

Tiered Scoring:

100% Match: If the user's search query (after normalization) is an exact phrase match within a product title.

Partial Match: If no exact 100% match is found, products are scored based on how many of their individual title words are present in the search query. Shorter, more relevant titles with matching words will score higher, ensuring the best partial matches appear first.
