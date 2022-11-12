import React from 'react';

function ProgressForm({ handlePageSubmit, total_pages }) {

    return (
        <div>
            <form className="progress-form-container" onSubmit={handlePageSubmit}>
                <div className="progress-page-setter">
                    <input type="number" name="pageCount" min={0} max={total_pages} className="peer w-full bg-gray-100 p-2" placeholder="Set pages read" style={{borderRadius:10}}></input>
                    <p className="mt-2 invisible peer-invalid:visible text-pink-600 text-sm">
                        Page not in range {0} to {total_pages}.
                    </p>
                </div>
                <button type="submit" className="btn">Set Pages</button>
            </form>
        </div>
    )
}

export default ProgressForm;