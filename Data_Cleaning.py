import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import warnings

# Ignore warnings for cleaner output to avoid any Chaos or disturbance in the output initially
warnings.filterwarnings('ignore') 

# The r stands for raw string. "Don't treat the backslashes \ as special characters, just read them as normal backslashes."
df = pd.read_csv(r"c:\Users\HP\Agileology_Works\Data_Analyst_Works\DA_Final_Project\Amazon_dataset.csv")

# Basic check
print(df.shape)
print(df.head())
print(df.columns.tolist())

# Check data types
print(df.dtypes)

# Check missing values
print(df.isnull().sum())

# Basic stats
print(df.describe())

# Convert Date to datetime
df['Date'] = pd.to_datetime(df['Date'], dayfirst=True, errors='coerce')

# Convert Qty to integer (it already is, but confirm)
df['Qty'] = df['Qty'].astype(int)

# Convert Amount to float (already float, just confirm)
df['Amount'] = df['Amount'].astype(float)

print(df.dtypes)
print(df['Date'].head())

print(df['Date'].tail())


# Drop junk columns
df.drop(columns=['index', 'Unnamed: 22', 'fulfilled-by'], inplace=True)

print("Columns after drop:", df.columns.tolist())
print("Shape now:", df.shape)


# Task -1 Identify and handle missing values.
df['Courier Status'].fillna('Unknown', inplace=True)

df['promotion-ids'].fillna('No Promotion', inplace=True)

df['ship-city'].fillna('Unknown', inplace=True)
df['ship-state'].fillna('Unknown', inplace=True)
df['ship-postal-code'].fillna(0, inplace=True)
df['ship-country'].fillna('Unknown', inplace=True)


# Task -2 Identify and remove duplicates.
print("Duplicate rows:", df.duplicated().sum()) #- 0 duplicates, so we are good.

#  Drop rows where Amount is null (only 7795 rows out of 128K — so safe to drop)
df.dropna(subset=['Amount', 'currency'], inplace=True)

# Verify no more nulls
print(df.isnull().sum())
print("Shape after handling nulls:", df.shape) 


# Task - 3 Correct inconsistent formatting in columns (text, numbers, currency, etc.).

# Currency Column
# Check what values exist
print(df['currency'].unique())

# Keep only valid currency rows (should all be INR for India)
print(df['currency'].value_counts())

# Standardize currency to uppercase
df['currency'] = df['currency'].astype(str).str.strip().str.upper()

print(df['currency'].unique())

# Amount Column

# Check for any negative or zero amounts (shouldn't exist in sales data)
print("Negative Amount rows:", df[df['Amount'] < 0].shape[0])
print("Zero Amount rows:", df[df['Amount'] == 0].shape[0])

# Replace 0 amounts with NaN and drop them (0 amount orders are invalid)
df['Amount'] = df['Amount'].replace(0, np.nan)
df.dropna(subset=['Amount'], inplace=True)

print("Shape after removing zero amounts:", df.shape)


# Qty Column

# Check for invalid qty values
print("Zero Qty rows:", df[df['Qty'] == 0].shape[0])
print("Negative Qty rows:", df[df['Qty'] < 0].shape[0])
print(df['Qty'].value_counts().head(10))

# Remove zero or negative qty rows
df = df[df['Qty'] > 0]

print("Shape after cleaning Qty:", df.shape)


# SKU & ASIN Columns
# Standardize SKU and ASIN to uppercase and strip spaces
df['SKU'] = df['SKU'].astype(str).str.strip().str.upper()
df['ASIN'] = df['ASIN'].astype(str).str.strip().str.upper()

print(df['SKU'].head())
print(df['ASIN'].head())

# Ship Postal Code

# Postal codes should be whole numbers, not floats like 560001.0
df['ship-postal-code'] = df['ship-postal-code'].astype(str).str.replace('.0', '', regex=False)

# Replace '0' (which we filled earlier for nulls) back to 'Unknown'
df['ship-postal-code'] = df['ship-postal-code'].replace('0', 'Unknown')

print(df['ship-postal-code'].head(10))


# B2B Column

# B2B should be True/False — just verify
print(df['B2B'].unique())
print(df['B2B'].value_counts())

# Convert to readable Yes/No string for easier use in Excel and Power BI
df['B2B'] = df['B2B'].map({True: 'Yes', False: 'No'})

print(df['B2B'].value_counts())


# promotion-ids Column

# Simplify promotion column — if it has a promo, mark as 'Promoted', else 'No Promotion'
df['Promotion_Type'] = df['promotion-ids'].apply(
    lambda x: 'No Promotion' if x == 'No Promotion' else 'Promoted'
)

print(df['Promotion_Type'].value_counts())

print("Final shape:", df.shape)
print(df.dtypes)
print(df.isnull().sum())


# Task - 4	Standardize values in categorical columns (status, category, ship-city, etc.).
text_cols = ['Status', 'Fulfilment', 'ship-service-level', 
             'Category', 'Size', 'ship-city', 'ship-state', 
             'Courier Status', 'Style']

for col in text_cols:
    df[col] = df[col].astype(str).str.strip().str.title()

print(df['Status'].unique())
print(df['Category'].unique())
print(df['ship-state'].unique())
print(df['ship-city'].unique())
print(df['Courier Status'].unique())
print(df['Style'].unique())
print(df['Fulfilment'].unique())
print(df['ship-service-level'].unique())
print(df['Size'].unique())


# Check distribution
print(df['Amount'].describe())


# Task - 5 Treat or flag outliers where necessary.
Q1 = df['Amount'].quantile(0.25)
Q3 = df['Amount'].quantile(0.75)
IQR = Q3 - Q1

lower = Q1 - 1.5 * IQR
upper = Q3 + 1.5 * IQR

print(f"Lower bound: {lower}, Upper bound: {upper}")
print("Outlier count:", df[(df['Amount'] < lower) | (df['Amount'] > upper)].shape[0])

# Flag outliers (don't delete — just mark them)
df['Amount_Outlier_Flag'] = ((df['Amount'] < lower) | (df['Amount'] > upper))

print(df['Amount_Outlier_Flag'].value_counts()) #  We flag them for reference but keep them.


# Task - 6 Create additional derived columns if helpful
df['Order_Month'] = df['Date'].dt.month
df['Order_Month_Name'] = df['Date'].dt.strftime('%B')
df['Order_Year'] = df['Date'].dt.year
df['Order_Week'] = df['Date'].dt.isocalendar().week.astype(int)
df['Order_Day'] = df['Date'].dt.day_name()

# Revenue band (segment orders by value)
df['Revenue_Band'] = pd.cut(df['Amount'], 
                             bins=[0, 200, 500, 1000, 5000, 99999],
                             labels=['Low', 'Medium', 'High', 'Premium', 'Luxury'])

print(df[['Date', 'Order_Month', 'Order_Month_Name', 'Order_Year', 'Revenue_Band']].head())


# EDA Charts (Python)

# ---- Chart 1: Category Distribution ----
plt.figure(figsize=(10,5))
df['Category'].value_counts().plot(kind='bar', color='steelblue')
plt.title('Distribution of Product Category')
plt.xlabel('Category')
plt.ylabel('Count')
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig('category_distribution.png')
plt.show()

# ---- Chart 2: Size Distribution ----
plt.figure(figsize=(10,5))
df['Size'].value_counts().plot(kind='bar', color='coral')
plt.title('Distribution of Product Size')
plt.xlabel('Size')
plt.ylabel('Count')
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig('size_distribution.png')
plt.show()

# ---- Chart 3: Status Distribution ----
plt.figure(figsize=(8,5))
df['Status'].value_counts().plot(kind='bar', color='mediumseagreen')
plt.title('Distribution of Order Status')
plt.xlabel('Status')
plt.ylabel('Count')
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig('status_distribution.png')
plt.show()

# ---- Chart 4: Top 10 Cities by Orders ----
plt.figure(figsize=(10,5))
df['ship-city'].value_counts().head(10).plot(kind='bar', color='mediumpurple')
plt.title('Top 10 Cities by Order Count')
plt.xlabel('City')
plt.ylabel('Orders')
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig('top_cities.png')
plt.show()

# ---- Chart 5: Top 10 States by Orders ----
plt.figure(figsize=(10,5))
df['ship-state'].value_counts().head(10).plot(kind='bar', color='tomato')
plt.title('Top 10 States by Order Count')
plt.xlabel('State')
plt.ylabel('Orders')
plt.xticks(rotation=45)
plt.tight_layout() #- automatically adjusts the spacing to avaoid overlap of lables and titles
plt.savefig('top_states.png')
plt.show()

# ---- Chart 6: Size vs Category (Heatmap) ----
pivot = df.groupby(['Category', 'Size']).size().unstack(fill_value=0)
plt.figure(figsize=(14,6))
sns.heatmap(pivot, annot=True, fmt='d', cmap='Blues')
plt.title('Product Size Count by Category')
plt.tight_layout()
plt.savefig('size_category_heatmap.png')
plt.show()


# Task - 7: Prepare the final cleaned dataset for analysis.
df.to_csv('Cleaned_Amazon_Dataset.csv', index=False)

print("Cleaned dataset saved successfully!")
print("Final shape is :", df.shape)
print(df.head())



# Load current final file

import pandas as pd

# Load without auto date parsing
df = pd.read_csv('Cleaned_Amazon_Dataset.csv',
                 low_memory=False,
                 parse_dates=False)

# Fix 1 - Date column
df['Date'] = pd.to_datetime(df['Date'],
                             format='%d-%m-%Y',
                             errors='coerce')

# Fix 2 - Strip trailing space from column names
df.columns = df.columns.str.strip()

# Fix 3 - Amount to float
df['Amount'] = df['Amount'].astype(float)

# Final verification
print('=== FINAL CHECK ===')
print('Shape:', df.shape)
print('Date dtype:', df['Date'].dtype)
print('Amount dtype:', df['Amount'].dtype)
print('Null dates:', df['Date'].isnull().sum())
print('Total nulls:', df.isnull().sum().sum())
print('Duplicates:', df.duplicated().sum())
print('Sales_Channel name:', repr(df.columns[4]))

# Save final file
df.to_csv('Cleaned_Amazon_Dataset_Final.csv', index=False)

print()
print('✅ File saved successfully!')
print('✅ Ready for Power BI!')








