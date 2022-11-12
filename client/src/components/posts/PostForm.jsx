import React, { useState } from 'react';

function PostForm({ book, handlePostSubmit }) {

    const [postTitle, setPostTitle] = useState('');
    const [postContent, setPostContent] = useState('');

    const handleTitleChange = (e) => {
        const newTitle = e.target.value;
        setPostTitle(newTitle);
    };

    const handlePostChange = (e) => {
        const newPost = e.target.value;
        setPostContent(newPost);
    };

    const { id, title } = book;

    function submitPost(e) {
        e.preventDefault();
        console.log(e.target);
        let token = localStorage.getItem("token");
        fetch(`http://localhost:5000/posts`, {
            method: 'POST',
            headers: {
                "Content-Type": "application/json",
                Authorization: token,
            },
            body: JSON.stringify({
                bookId: id,
                title: postTitle,
                content: postContent
            })
        }).then((res) => {
            if (res.ok) {
                return res.json();
            } else if (res.status == "401") {
                throw new Error("Unauthorized Request. Must be signed in.");
            }
        })
            .then((data) => {
                handlePostSubmit(data);
                setPostTitle('');
                setPostContent('');
            })
            .catch((err) => {
                alert(err);
            });
    }

    return (
        <>
        <div className="line-break" />
            <div className="post-form-div">
                <form className="post-form-container" onSubmit={submitPost}>
                    <h1 className="post-form-header">Post Your Thoughts on {title}</h1>
                    <input
                        type="text"
                        name="postTitle"
                        value={postTitle}
                        onChange={handleTitleChange}
                        maxLength={50}
                        placeholder="Post title here"
                        className="post-form-title input input-bordered input-info w-full max-w-xs" />
                    <textarea
                        name="postContent"
                        value={postContent}
                        onChange={handlePostChange}
                        className="post-form-content textarea textarea-info"
                        placeholder={`Share your thoughts on ${title} here`}></textarea>
                    <button type="submit" className="btn post-form-button">Share Post</button>
                </form>
            </div>
            <div className="line-break" />
        </>
    );
}

export default PostForm;