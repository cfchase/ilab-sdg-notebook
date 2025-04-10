import requests
import time

def wait_for_api(
    url,
    method='GET',
    token=None,
    expected_status=200,
    timeout=10,
    retry_interval=5,
    max_retries=None
):
    """
    Waits for an API endpoint to become available.

    Parameters:
    - url: API endpoint URL.
    - method: HTTP method (default 'GET').
    - token: Bearer token for authentication (optional).
    - expected_status: HTTP status code considered 'available' (default 200).
    - timeout: Timeout for each request (seconds).
    - retry_interval: Time between retries (seconds).
    - max_retries: Optional max number of retries. If None, retries forever.
    """

    headers = {
        'Authorization': f'Bearer {token}'
    } if token else {}

    attempt = 0
    while True:
        try:
            response = requests.request(method, url, headers=headers, timeout=timeout)
            if response.status_code == expected_status:
                print(f"✅ API is available: {url} (Status {response.status_code})")
                break
            else:
                print(f"🔄 API responded with status {response.status_code}, waiting...")
        except requests.RequestException as e:
            print(f"⚠️ Error contacting API: {e}, retrying...")

        attempt += 1
        if max_retries is not None and attempt >= max_retries:
            raise TimeoutError(f"API not available after {max_retries} retries.")

        time.sleep(retry_interval)

